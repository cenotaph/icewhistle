# frozen_string_literal: true

class Admin::PostsController < Admin::BaseController
  has_scope :page, default: 1
  respond_to :html

  def index
    @posts = Post.order(' id DESC').page(params[:page]).per(30)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    respond_with @post, location: -> { admin_posts_path } if @post.save
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @post.discard
    redirect_to admin_posts_path
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = 'Post updated'
      redirect_to @post
    else
      flash[:error] = 'Error updating post'
    end
  end

  protected

  def post_params
    params.require(:post).permit(:title, :body, :password, :tag_list, :image, :extended, :published, videos_attributes: %i[id bytes content_type url  progressive_video _destroy], audiopodcasts_attributes: %i[id bytes content_type url _destroy], photos_attributes: %i[id filename _destroy])
  end
end
