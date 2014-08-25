class Admin::ProjectsController <  Admin::BaseController
  protected
  
  def permitted_params
    params.permit(:project => [:name, :projecttype, :url1, :url2, :started, :finished, :description, :major, :sortorder ])
  end
end
