class CvController < ApplicationController
 layout 'cv'
 
 # caches_action :index, :expires_in => '4 days'
 
  def index
    @schools = School.all.order('finished DESC')
    @jobs = Job.all.order('realdate DESC, id DESC')
    @publications = Publication.all.order('sortorder, realdate DESC, id DESC')
    @projects = Project.all.order('sortorder, finished DESC, id DESC')
    @skill = Skill.all
  end
    
end
