module Dashboard
  class SearchController < ApplicationController
    def new
      query = params[:search][:query].tr(" ", ",")
      @photos = Flickr.photos(query)
      ahoy.track 'User loaded photo from Flickr', group: :image, status: :loaded, search_query: query
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
