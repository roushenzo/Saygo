class CountriesController < InheritedResources::Base
  layout 'countries'

  def index
    @sight_of_the_day = Page.current_sight_of_the_day
    @countries = Country.all
  end
end
