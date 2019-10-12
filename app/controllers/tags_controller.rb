class TagsController < ApplicationController
 

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @posts = Post.published.tagged_with(params[:id])
    @posts += Crumble.tagged_with(params[:id])
    if @posts.nil?
        @posts = []
    end

    flash[:notice] = 'Showing items tagged with \''+params[:id]+'\':'
    @tag = params[:id]
    @posts = @posts.sort{|x,y| y.created_at <=> x.created_at }

    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(15)
    render :template => 'posts/index' , layout: get_layout 
  end
  
end