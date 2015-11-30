# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #before_filter :load_sidebars


  def get_layout
    hostname = request.host.gsub(/\..*/, '')
    domain = request.domain
    if domain =~ /seriousintrospection/
      return hostname
    else
      return 'application'
    end

      # return (hostname == 'services' ? 'services' : 'application')
  end
  
  def load_sidebars
    # @links = Link.all.order(:sortorder, :category_id, :name)
    @news = Post.tagged_with('frontpage').order('created_at DESC').page(params[:page]).per(3)
  end
  
end
