class FrontpageController < ApplicationController

  
  def index
    @posts = Post.published.order('created_at DESC').page(params[:page]).per(10)
    @crumbles = Crumble.where("icon is not null").order_by_rand.limit(5).all
  end
  
end
