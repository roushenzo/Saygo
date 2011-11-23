class PagesController < InheritedResources::Base
  def show
    @page = Page.find_by_title(params[:id]) || Page.find(params[:id])
  end
end
