class Flickr
  FlickRaw.api_key = ENV['FLICKRAW_API_KEY']
  FlickRaw.shared_secret = ENV['FLICKRAW_SHARED_SECRET']

  class << self
    def photos(query)
      search(query).map { |el| url(info(el.id)) }
    end

    def search(query)
      flickr.photos.search(tags: query, per_page: 10)
    end

    def info(id)
      flickr.photos.getInfo(photo_id: id)
    end

    def url(info)
      FlickRaw.url(info)
    end
  end
end
