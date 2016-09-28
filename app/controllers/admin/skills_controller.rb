class Admin::SkillsController <  Admin::BaseController
 respond_to :html
 
 def new
   @skill = Skill.new
 end
 
 def edit
   @skill = Skill.find(params[:id])
 end
 
 def create
   @skill = Skill.new(permitted_params)
   if @skill.save
     respond_with @skill, location: -> { admin_skills_path }
   end
   
 end
 
 def destroy
   @skill = Skill.find(params[:id])
   @skill.destroy!
   redirect_to admin_skills_path
 end
 
 def update
   @skill = Skill.find(params[:id])
   if @skill.update_attributes(permitted_params)
     respond_with @skill, location: -> { admin_skills_path }
   end
 end
 

 def index
   @skills = Skill.all
 end

 private 
  def permitted_params
    params.require(:skill).permit(:skills, :skilltype)
  end
end
