class CommentsController < InheritedResources::Base

  belongs_to :page

  def create
    @comment = parent.comments.build(params[:comment])
    if @comment.save
      redirect_to @page.url, :notice => "grats"
    else
      @country = @page.country
      @city = @page.city
      render :template => "pages/show"
    end
  end

end
