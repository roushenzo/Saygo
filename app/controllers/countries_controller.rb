class CountriesController < InheritedResources::Base
  layout 'countries'

  def index
    @sight_of_the_day = Page.current_sight_of_the_day
    country_pages_ids = Page.where(:active => true, :city_id => nil).select(:country_id).map(&:country_id).uniq
    @countries = Country.where(:id => country_pages_ids)
    @top_countries = Country.where(:id => country_pages_ids).limit(10) # TODO: use rating for countries in the future
  end
end
