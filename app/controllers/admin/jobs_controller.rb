class Admin::JobsController < Admin::BaseController
  def create
    create! { admin_jobs_path }
  end
  
  def update
    update! { admin_jobs_path }
  end
  
  
  protected
  
  def permitted_params
    params.permit(:job => [:started, :finished, :employer, :department, :address1, :address2, :city, :state, :postcode, :country, :title, :description, :major, :realdate, :sortoder])
  end
  
end