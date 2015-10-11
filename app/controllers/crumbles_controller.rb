class CrumblesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :delete]

  def by_date
    @crumbles = Crumble.order('datestamp').group_by{|x| x.datestamp.nil? ? nil : x.datestamp.strftime('%Y') }
  end

  def index
   @crumbles = Crumble.order('created_at DESC').page(params[:page]).per(9)

    respond_to do |format|
      format.html # index.html.erb
      format.rss  { render :rss => @crumbles }
    end
  end

  def show
    @crumble = Crumble.friendly.find(params[:id])
    set_meta_tags :title => @crumble.title, 
                  canonical: url_for(@crumble),
                  og: {image: (@crumble.icon? ?  [ @crumble.icon.url(:midsize).gsub(/^https/, 'http'), { secure_url: @crumble.icon.url(:midsize) } ] : 'http://icewhistle.com/icewhistle.jpg'), 
                        title: @crumble.title, type: 'website', url: url_for(@crumble)
                      }, 
                  twitter: {card: 'summary', site: '@hyksos'}
  end

  # GET /crumbles/new
  # GET /crumbles/new.xml
  def new
    @crumble = Crumble.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @crumble }
    end
  end

  # GET /crumbles/1/edit
  def edit
    @crumble = Crumble.friendly.find(params[:id])
  end

  # POST /crumbles
  # POST /crumbles.xml
  def create
    @crumble = Crumble.new(params[:crumble])

    respond_to do |format|
      if @crumble.save
        flash[:notice] = 'Crumble was successfully created.'
        format.html { redirect_to(@crumble) }
        format.xml  { render :xml => @crumble, :status => :created, :location => @crumble }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crumble.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /crumbles/1
  # PUT /crumbles/1.xml
  def update
    @crumble = Crumble.find(params[:id])

    respond_to do |format|
      if @crumble.update_attributes(params[:crumble])
        flash[:notice] = 'Crumble was successfully updated.'
        format.html { redirect_to(@crumble) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crumble.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /crumbles/1
  # DELETE /crumbles/1.xml
  def destroy
    @crumble = Crumble.find(params[:id])
    @crumble.destroy

    respond_to do |format|
      format.html { redirect_to(crumbles_url) }
      format.xml  { head :ok }
    end
  end
end
