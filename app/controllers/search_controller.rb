class SearchController < ApplicationController
  def show
    @page = Page.new(:title => params[:title])
    @pages = @page.search(params)
  end
end
