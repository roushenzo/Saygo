# -*- encoding : utf-8 -*-
class CommentsController < InheritedResources::Base

  belongs_to :page

  def create
    p params
    @comment = parent.comments.build(params[:comment].merge(:ip => request.remote_ip))
    if @comment.save
      redirect_to @page.url, :notice => "Вы успешно оставили отзыв!"
    else
      @country = @page.country
      @city = @page.city
      render :template => "pages/show"
    end
  end

end
