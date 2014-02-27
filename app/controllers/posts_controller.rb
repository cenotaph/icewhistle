class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :delete]

  def index
    @posts = Post.includes(:comments).order('created_at DESC').page(params[:page]).per(12)
  end
  
  def show
    @post = Post.find(params[:id])
  end
  

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Successfully created post."
      redirect_to @post
    else
      render :action => 'new'
    end
  end
  

  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Successfully destroyed post."
    redirect_to posts_url
  end
end
