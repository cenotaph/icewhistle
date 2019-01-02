# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  protect_from_forgery

  def get_layout
    hostname = request.host.gsub(/\..*/, '')
    domain = request.domain
    if domain =~ /seriousintrospection/
      if hostname == 'services' 
        return 'services'
      else
        return 'seriousintrospection'
      end
    else
      return 'application'
    end

      # return (hostname == 'services' ? 'services' : 'application')
  end

  def load_sidebars
    # @links = Link.all.order(:sortorder, :category_id, :name)
    @news = Post.tagged_with('frontpage').order('created_at DESC').page(params[:page]).per(3)
  end

  protected

  def render_not_found_response(exception)
    respond_to do |format|
      format.html { render template: "#{Rails.root}/public/404.html" }
      format.json {
        render json: { errors: [{ detail: exception.message,
                                title: 'Item not found',
                                status: 404
                              }]
                    }, status: :not_found
        }
    end
  end
end
