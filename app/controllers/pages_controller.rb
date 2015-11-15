class PagesController < ApplicationController
  
  layout :get_layout
    
    
  def show  
    @page = Page.friendly.find(params[:id])
    

    set_meta_tags :title => @page.title.html_safe, 
      canonical: url_for(@page),
      og: { title: @page.title.html_safe, 
            url: url_for(@page), 
            image: @page.image.blank? ? '' : @page.image.url(:midsize)
          }
  end
end