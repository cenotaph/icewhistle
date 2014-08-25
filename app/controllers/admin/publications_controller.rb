class Admin::PublicationsController < Admin::BaseController

  protected
  
  def permitted_params
    params.permit(:publication => [:title, :format, :publisher, :date, :description, :major, :realdate, :icon, :sortorder ])
  end
    
end
