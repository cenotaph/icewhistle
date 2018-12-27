class Admin::SchoolsController < ApplicationController
  before_action :authenticate_user!
   # layout 'admin'
   
  def authenticate
      authenticate_or_request_with_http_basic do |name, pass|
            #User.authenticate(name, pass)
            name == 'fail' && pass == '!cewhistle@@@'      
      end
  end
  
  
  # GET /schools
  # GET /schools.xml
  def index
    @schools = School.find(:all)
      @skills = Skill.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schools }
    end
  end

  # GET /schools/1
  # GET /schools/1.xml
  def show
    @school = School.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @school }
    end
  end
  
  
  
  # GET /schools/new
  # GET /schools/new.xml
  def new
    @school = School.new
  @skills = Skill.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @schools }
    end
  end

  # GET /schools/1/edit
  def edit
    @school = School.find(params[:id])
    @categories = Category.find(:all)
      @skills = Skill.find(:all)
  end

  # POST /schools
  # POST /schools.xml
  def create
    @school = School.new(params[:school])
  @skills = Skill.new(params[:skill])
    respond_to do |format|
      if @school.save
        flash[:notice] = 'Schools was successfully created.'
        format.html { redirect_to([:admin, @school]) }
        format.xml  { render :xml => @school, :status => :created, :location => @school }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schools/1
  # PUT /schools/1.xml
  def update
    @school = School.find(params[:id])

    respond_to do |format|
      if @school.update_attributes(params[:school])
        if @skills.update_attributes(params[:skill])
        flash[:notice] = 'School was successfully updated.'
        format.html { redirect_to([:admin,@school]) }
        format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  def skillsnew
      @skills = Skill.new
  end
  
  # DELETE /schools/1
  # DELETE /schools/1.xml
  def destroy
    @schools = School.find(params[:id])
    @schools.destroy

    respond_to do |format|
      format.html { redirect_to(admin_schools_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
