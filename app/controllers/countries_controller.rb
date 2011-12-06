class CountriesController < InheritedResources::Base
  layout 'countries'

  def index
    @sight_of_the_day = Page.current_sight_of_the_day
    @countries = Country.all
    @top_countries = Country.limit(10) # TODO: use rating for countries in the future
  end
end
