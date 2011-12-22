class PagesController < InheritedResources::Base
  def show
    @page = Page.search(params.merge(:force => true)).first
    raise ActiveRecord::RecordNotFound unless @page
    @country = @page.country
    @city = @page.city
    @category = @page.category
    @description_type = @page.description_type
  end
end
