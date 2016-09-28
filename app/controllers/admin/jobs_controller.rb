class Admin::JobsController <  Admin::BaseController
 respond_to :html
 
 def new
   @job = Job.new
 end
 
 def edit
   @job = Job.find(params[:id])
 end
 
 def create
   @job = Job.new(permitted_params)
   if @job.save
     respond_with @job, location: -> { admin_jobs_path }
   end
   
 end
 
 def destroy
   @job = Job.find(params[:id])
   @job.destroy!
   redirect_to admin_jobs_path
 end
 
 def update
   @job = Job.find(params[:id])
   if @job.update_attributes(permitted_params)
     respond_with @job, location: -> { admin_jobs_path }
   end
 end
 

 def index
   @jobs = Job.all
 end

  
  protected
  
  def permitted_params
    params.require(:job).permit(:started, :finished, :employer, :department, :address1, :address2, :city, :state, :postcode, :country, :title, :description, :major, :realdate, :sortoder)
  end
  
end