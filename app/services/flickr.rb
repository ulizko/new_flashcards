class Flickr
  FlickRaw.api_key = ENV['FLICKRAW_API_KEY']
  FlickRaw.shared_secret = ENV['FLICKRAW_SHARED_SECRET']
  
  def self.photos(query)
    ids = flickr.photos.search(tags: query).first(10).map(&:id)   
    info = ids.map { |id| flickr.photos.getInfo(:photo_id => id) }
    info.map { |i| FlickRaw.url(i) }
    
  end
end