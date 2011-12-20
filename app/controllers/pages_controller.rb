class PagesController < InheritedResources::Base
  def show
    page = Page.new
    @page = page.search(params).first
    @country = page.country
    @city = page.city
    @category = page.category
    @description_type = page.description_type
    raise ActiveRecord::RecordNotFound unless @page
  end
end
