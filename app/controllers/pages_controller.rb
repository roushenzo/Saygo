class PagesController < InheritedResources::Base
  before_filter :find_page

  def show
    @page = @page.find(params[:id]) if params[:id].present?
  end

  private
  def find_page
    @country = Country.find_by_id(params[:country_id])
    @city = City.find_by_id(params[:city_id])
    @category = Category.find_by_id(params[:id])
    @page = Page
    @page = @page.where(:country_id => @country.id) if @country.present?
    @page = @page.where(:city_id => @city.id) if @city.present?
    @page = @page.where(:category_id => @category.id) if @category.present?
  end
end
