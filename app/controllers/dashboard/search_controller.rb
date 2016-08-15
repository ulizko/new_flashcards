module Dashboard
  class SearchController < ApplicationController
    def new
      query = params[:search][:query].gsub(" ", ",")
      @photos = Flickr.photos(query)
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end
