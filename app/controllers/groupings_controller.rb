class GroupingsController < ApplicationController
  
  before_filter :login_required
  
  def index
    @groupings = Grouping.all
  end
  
  def show
    @grouping = Grouping.find(params[:id])
  end
  
  def new
    @grouping = Grouping.new
  end
  
  def create
    @grouping = Grouping.new(params[:grouping])
    if @grouping.save
      flash[:notice] = "Successfully created grouping."
      redirect_to @grouping
    else
      render :action => 'new'
    end
  end
  
  def edit
    @grouping = Grouping.find(params[:id])
  end
  
  def update
    @grouping = Grouping.find(params[:id])
    if @grouping.update_attributes(params[:grouping])
      flash[:notice] = "Successfully updated grouping."
      redirect_to @grouping
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @grouping = Grouping.find(params[:id])
    @grouping.destroy
    flash[:notice] = "Successfully destroyed grouping."
    redirect_to groupings_url
  end
end
