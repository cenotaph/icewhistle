class PostsController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :delete]

  def index
    @posts = Post.includes(:comments).published.order('created_at DESC').page(params[:page]).per(6)

  end
  
  def show

    @post = Post.friendly.find(params[:id])
    set_meta_tags :title => @post.title, 
                  canonical: url_for(@post),
                  og: {image: (@post.image? ?  [ @post.image.url(:midsize).gsub(/^https/, 'http'), { secure_url: @post.image.url(:midsize) } ] : 'http://icewhistle.com/icewhistle.jpg'), 
                        title: @post.title, type: 'website', url: url_for(@post),
                        description: ActionView::Base.full_sanitizer.sanitize(@post.body[0..500]) + "..."
                      }, 
                  twitter: {card: 'summary', site: '@hyksos'}
    respond_to do |format|
      format.html { render layout: get_layout }
      format.all  { render(text: 'Not Found', status: :unsupported_media_type) }
    end
  end
  
  def new
    redirect_to new_admin_post_path
  end

end
