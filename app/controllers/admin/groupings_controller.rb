class Admin::GroupingsController < ApplicationController
  before_filter :authenticate_user!
  def authenticate
      authenticate_or_request_with_http_basic do |name, pass|
            #User.authenticate(name, pass)
            name == 'fail' && pass == '!cewhistle@@@'      
      end
  end
  
  # GET /groupings
  # GET /groupings.xml
  def index
    @groupings = Grouping.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groupings }
    end
  end

  # GET /groupings/1
  # GET /groupings/1.xml
  def show
    @grouping = Grouping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grouping }
    end
  end

  # GET /groupings/new
  # GET /groupings/new.xml
  def new
    @grouping = Grouping.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grouping }
    end
  end

  # GET /groupings/1/edit
  def edit
    @grouping = Grouping.find(params[:id])
  end

  # POST /groupings
  # POST /groupings.xml
  def create
    @grouping = Grouping.new(params[:grouping])

    respond_to do |format|
      if @grouping.save
        flash[:notice] = 'Grouping was successfully created.'
        format.html { redirect_to([:admin,@grouping]) }
        format.xml  { render :xml => @grouping, :status => :created, :location => @grouping }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grouping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groupings/1
  # PUT /groupings/1.xml
  def update
    @grouping = Grouping.find(params[:id])

    respond_to do |format|
      if @grouping.update_attributes(params[:grouping])
        flash[:notice] = 'Grouping was successfully updated.'
        format.html { redirect_to([:admin,@grouping]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grouping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groupings/1
  # DELETE /groupings/1.xml
  def destroy
    @grouping = Grouping.find(params[:id])
    @grouping.destroy

    respond_to do |format|
      format.html { redirect_to(admin_groupings_url) }
      format.xml  { head :ok }
    end
  end
  
end
