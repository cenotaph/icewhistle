class Admin::PostsController < Admin::BaseController
  has_scope :page, :default => 1
  respond_to :html
  
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(30)
  end
  
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.friendly.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      respond_with @post, location: -> { admin_posts_path }
    end
    
  end
  
  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy!
    redirect_to admin_posts_path
  end
  
  def update
    @post = Post.friendly.find(params[:id])
    if @post.update_attributes(post_params)
      respond_with @post, location: -> { admin_posts_path }
    end
  end
  
  
  protected
  
  def post_params
    params.require(:post).permit(:title, :body, :tag_list, :image, :extended, :published, videos_attributes: [:id, :bytes, :content_type, :url, :_destroy], audiopodcasts_attributes: [:id, :bytes, :content_type, :url, :_destroy], photos_attributes: [:id, :filename, :_destroy])
  end
  
end