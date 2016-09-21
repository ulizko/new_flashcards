class StatisticsController < ApplicationController
  skip_after_action :track_action
  after_action :verify_authorized, only: :index

  def index
    authorize :statistics, :index?
  end

  def loads_images_from_flickr
    images = Ahoy::Event.where("name LIKE ?", "%Flickr%").
              group_by_day(:time, format: "%d %b", range: 1.months.ago..Time.now).count
    render json: images
  end

  def visits_use_social
    visits = Visit.group_by_day(:started_at, format: "%d %b", range: 1.months.ago..Time.now).count
    render json: visits
  end

  def results_review_cards
    results = Ahoy::Event.where(name: 'User reviewed card').group("properties::json->>'state'").
                group_by_day(:time, format: "%d %b", range: 1.months.ago..Time.now).count
    render json: results.chart_json
  end

  def visits_from_countries
    render json: Visit.group(:country).count
  end
end
