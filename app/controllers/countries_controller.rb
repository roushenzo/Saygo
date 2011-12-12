class CountriesController < InheritedResources::Base
  layout 'countries'

  def index
    @sight_of_the_day = Page.current_sight_of_the_day
    @countries = Country.all
    @top_countries = Country.limit(10) # TODO: use rating for countries in the future
    @page = Page.new
    @search_categories = Category.where(:show_in_the_search_bar => true)
  end

end
