class CvController < ApplicationController
 layout 'cv'
 
 # caches_action :index, :expires_in => '4 days'
 
  def index
    @schools = School.find(:all, :order => 'finished DESC')
    @jobs = Job.find(:all, :order => 'realdate DESC, id DESC')
    @publications = Publication.find(:all, :order => 'sortorder, realdate DESC, id DESC')
    @projects = Project.find(:all, :order => 'sortorder, finished DESC, id DESC')
    @skill = Skill.find(:all)
  end
    
end
