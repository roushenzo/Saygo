class SearchController < ApplicationController
  layout 'search'
  def show
    @page = Page.new
    @selected_category = Category.find(params[:category_id]) if params[:category_id].present?
    @page.category = @selected_category
    @selected_country = Country.find(params[:country_id]) if params[:country_id].present?
    @page.country = @selected_country
    @selected_city = Country.find(params[:city_id]) if params[:city_id].present?
    @page.city = @selected_city
    @search_categories = Category.for_search_bar
  end
end
