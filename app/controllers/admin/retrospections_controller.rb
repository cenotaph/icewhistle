class Admin::RetrospectionsController <  Admin::BaseController
 
  def index
    @retrospections = Retrospection.all
  end
  
  def show
    @retrospection = Retrospection.find(params[:id])
  end
  
  protected
  

end
