require 'rails_helper'
require_relative '../../app/services/flickr.rb'

RSpec.describe 'Flickr', type: :feature do
  describe "class methods" do

    let(:search_result) do
      VCR.use_cassette("flickr/search") do
        flickr.photos.search(tags: 'car', per_page: 10)
      end
    end

    let(:info) do
      VCR.use_cassette("flickr/info") do
        flickr.photos.getInfo(photo_id: '28439083854')
      end
    end

    let(:url) { "https://farm9.staticflickr.com/8843/28439083854_49cd1a4ab6.jpg" }

    after(:each) do
      VCR.eject_cassette
    end

    context '.search' do
      it 'should return response list photos' do
        VCR.insert_cassette("flickr/search") do
          allow(flickr.photos).to receive(:search).with(tags: 'car', per_page: 10)
          Flickr.search('car')
        end
      end
    end

    context '.info' do
      it 'get info about photo' do
        VCR.insert_cassette("flickr/search") do
          allow(flickr.photos).to receive(:getInfo).with(photo_id: '28439083854')
          Flickr.info('28439083854')
        end
      end
    end

    context '.url' do
      it 'get photo url' do
        VCR.insert_cassette("flickr/info") do
          allow(FlickRaw).to receive(:url).with(info)
          result = Flickr.url(info)
          expect(result).to match(%r{^https:\/\/farm\d\.staticflickr\.com\/.+\.jpg$})
        end
      end
    end

    context '.photos' do
      it 'should return array urls photos' do
        VCR.insert_cassette("flickr/search") do
          allow(flickr.photos).to receive(:search).with(tags: 'car', per_page: 10).and_return(search_result)
          allow(flickr.photos).to receive(:getInfo).with(photo_id: '28439083854').exactly(10).and_return(info)
          allow(FlickRaw).to receive(:url).with(info).exactly(10).and_return(url)
          result = Flickr.photos('car')
          expect(result).to be(Array)
        end
      end
    end
  end
end
