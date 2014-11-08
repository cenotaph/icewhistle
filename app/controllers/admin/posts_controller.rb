class Admin::PostsController < Admin::BaseController
  has_scope :page, :default => 1
  
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(30)
  end
  
  def create
    create! { admin_posts_path }
  end
  
  def update
    update! { admin_posts_path }
  end
  
  protected
  
  def permitted_params
    params.permit(:post => [:title, :body, :tag_list, :image, :extended, :published, photos_attributes: [:id, :filename]])
  end
  
end