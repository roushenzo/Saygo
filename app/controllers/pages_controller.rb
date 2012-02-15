class PagesController < InheritedResources::Base
  def show

    @page = admin_user_signed_in? ? Page.unscoped.search(params.merge(:force => true)).first : Page.search(params.merge(:force => true)).first
    raise ActiveRecord::RecordNotFound unless @page
    @country = @page.country
    @city = @page.city
    @category = @page.category
    @description_type = @page.description_type
    @comment = @page.comments.build unless (@page.country? || @page.city?)
  end
end
