class SearchController < ApplicationController
  def show
    @page = Page.new(:title => params[:title])
    @pages = @page.search(params).where('category_id is NOT NULL')
  end
end
