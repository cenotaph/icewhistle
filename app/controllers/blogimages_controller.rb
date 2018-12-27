class BlogimagesController < ApplicationController
  before_action :login_required
  
  def index
    @blogimages = Blogimage.all
    render :layout => false
  end
  
  def show
    @blogimage = Blogimage.find(params[:id])
  end
  
  def new
    @blogimage = Blogimage.new
  end
  
  def create
    @blogimage = Blogimage.new(params[:blogimage])
    if @blogimage.save
      flash[:notice] = "Successfully created blogimage."
      redirect_to  :action => :new
    else
      render :action => 'new'
    end
  end
  
  def edit
    @blogimage = Blogimage.find(params[:id])
  end
  
  def update
    @blogimage = Blogimage.find(params[:id])
    if @blogimage.update_attributes(params[:blogimage])
      flash[:notice] = "Successfully updated blogimage."
      redirect_to @blogimage
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @blogimage = Blogimage.find(params[:id])
    @blogimage.destroy
    flash[:notice] = "Successfully destroyed blogimage."
    redirect_to blogimages_url
  end
end
