class Flickr
  FlickRaw.api_key = ENV['FLICKRAW_API_KEY']
  FlickRaw.shared_secret = ENV['FLICKRAW_SHARED_SECRET']

  class << self
    def photos(query)
      ids = search(query).map(&:id)
      info = ids.map { |id| info(id) }
      info.map { |i| url(i) }
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
