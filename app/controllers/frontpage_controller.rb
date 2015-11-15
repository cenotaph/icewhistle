class FrontpageController < ApplicationController

  layout :get_layout

  
  def index
    @posts = Post.published.order('created_at DESC').page(params[:page]).per(10)
    @crumbles = Crumble.where("icon is not null").order_by_rand.limit(5).all
    set_meta_tags :title => 'John W. Fail', 
                  canonical: 'http://icewhistle.com/',
                  og: {image: ( 'http://icewhistle.com/icewhistle.jpg'), 
                        title: 'John W. Fail', type: 'website', url:  'http://icewhistle.com/'
                      }, 
                  twitter: {card: 'summary', site: '@hyksos'}
    if get_layout == 'services'
      set_meta_tags :title => 'SI Services', 
                    canonical: 'http://services.johnw.fail/',
                    og: {image: ( 'http://services.johnw.fail/assets/services/ernest.jpg'), 
                          title: 'SI Services', type: 'website', url:  'http://services.johnw.fail/'
                        }, 
                    twitter: {card: 'summary', site: '@hyksos'}
      render template: 'frontpage/services'
    end
      
  end
  
end
