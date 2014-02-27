class Admin::LinksController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  def authenticate
      authenticate_or_request_with_http_basic do |name, pass|
            #User.authenticate(name, pass)
            name == 'fail' && pass == '!cewhistle@@@'      
      end
  end
  
  
  # GET /links
  # GET /links.xml
  def index
    @links = Link.order(:sortorder)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end
  
  
  
  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
    @categories = Category.find(:all)
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])

    respond_to do |format|
      if @link.save
        flash[:notice] = 'Links was successfully created.'
        format.html { redirect_to(admin_links_path) }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:notice] = 'Link was successfully updated.'
        format.html { redirect_to(admin_links_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @links = Link.find(params[:id])
    @links.destroy

    respond_to do |format|
      format.html { redirect_to(admin_links_url) }
      format.xml  { head :ok }
    end
  end
  
end
