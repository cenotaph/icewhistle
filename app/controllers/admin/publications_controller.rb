class Admin::PublicationsController < Admin::BaseController
  
  
   respond_to :html
  def new
    @publication = Publication.new
  end
  
  def edit
    @publication = Publication.find(params[:id])
  end
  
  def create
    @publication = Publication.new(permitted_params)
    if @publication.save
      respond_with @publication, location: -> { admin_publications_path }
    end
    
  end
  
  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy!
    redirect_to admin_publications_path
  end
  
  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(permitted_params)
      respond_with @publication, location: -> { admin_publications_path }
    end
  end
  

  def index
    @publications = Publication.all
  end
  
  protected
  
  def permitted_params
    params.require(:publication).permit(:title, :format, :publisher, :date, :description, :major, :realdate, :icon, :sortorder)
  end
    
end
