class SearchController < ApplicationController
 

  def index
    @posts = ThinkingSphinx.search(params[:search],:order => 'created_at DESC').page(params[:page]).per(10)
    if @posts.size == 0
    	flash[:notice] = 'Sorry, no results found for '+params[:search]
    else
    	flash[:notice] = 'Search results for <b><i>'+ params[:search] + '</b></i>:'
    end
    
    @search = params[:search]
    render :template => 'posts/index'

  end

end
