class Admin::SkillsController < Admin::BaseController
  
  protected
  
  def permitted_params
    params.permit(:skill => [:skills, :skilltype])
  end
end
