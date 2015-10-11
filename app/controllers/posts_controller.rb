class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :delete]

  def index
    @posts = Post.includes(:comments).published.order('created_at DESC').page(params[:page]).per(6)
  end
  
  def show
    @post = Post.friendly.find(params[:id])
    set_meta_tags :title => @post.title, 
                  canonical: url_for(@post),
                  og: {image: (@post.image? ?  [ @post.image.url(:midsize).gsub(/^https/, 'http'), { secure_url: @post.image.url(:midsize) } ] : 'http://icewhistle.com/assets/icewhistle_combined-0d25282030b3a76a6bf4eb06b685f17a.png'), 
                        title: @post.title, type: 'website', url: url_for(@post)
                      }, 
                  twitter: {card: 'summary', site: '@hyksos'}
  end
  
  def new
    redirect_to new_admin_post_path
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
