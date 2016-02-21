class Admin::ProjectsController <  Admin::BaseController
 respond_to :html
 
 def new
   @project = Project.new
 end
 
 def edit
   @project = Project.find(params[:id])
 end
 
 def create
   @project = Project.new(permitted_params)
   if @project.save
     respond_with @project, location: -> { admin_projects_path }
   end
   
 end
 
 def destroy
   @project = Project.find(params[:id])
   @project.destroy!
   redirect_to admin_projects_path
 end
 
 def update
   @project = Project.find(params[:id])
   if @project.update_attributes(permitted_params)
     respond_with @project, location: -> { admin_projects_path }
   end
 end
 

 def index
   @projects = Project.all
 end
 
  protected
  
  def permitted_params
    params.require(:project).permit(:name, :projecttype, :url1, :url2, :started, :finished, :description, :major, :sortorder)
  end
end
