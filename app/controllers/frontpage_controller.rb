class FrontpageController < ApplicationController

  
  def index
    @posts = Post.published.order('created_at DESC').page(params[:page]).per(10)
    @crumbles = Crumble.where("icon is not null").random(5)
  end
  
end
