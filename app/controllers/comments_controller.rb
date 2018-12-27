# class CommentsController < InheritedResources::Base
#
#   before_action :load_post
#
#   def load_post
#     @item = Post.find(params[:post_id]) if params[:post_id]
#     @item = Crumble.find(params[:crumble_id]) if params[:crumble_id]
#    end
#
#   # GET /comments
#   # GET /comments.xml
#   def index
#     @comments = @item.comments.find(:all)
#
#     respond_to do |format|
#       format.html # index.html.erb
#       format.xml  { render :xml => @comments }
#     end
#   end
#
#
#
#   # GET /comments/1
#   # GET /comments/1.xml
#   def show
#     @comment = @item.comments.find(params[:id])
#
#     respond_to do |format|
#       format.html # show.html.erb
#       format.xml  { render :xml => @comment }
#     end
#   end
#
#   # GET /comments/new
#   # GET /comments/new.xml
#   def new
#     @comment = @item.comments.build
#
#     respond_to do |format|
#       format.html # new.html.erb
#       format.xml  { render :xml => @comment }
#     end
#   end
#
#   # GET /comments/1/edit
#   def edit
#     @comment = @item.comments.find(params[:id])
#   end
#
#   # POST /comments
#   # POST /comments.xml
#   def create
#     @comment = @item.comments.build(params[:comment])
#
#     if verify_recaptcha(:model => @item) && @comment.save
#       flash[:notice] = 'Comment was successfully created.'
#       # redirect_to :id => @item.slug, :action => :show, :controller => @item.class.to_s.tableize
#     else
#       if @item.class == Crumble
#         @crumble = @item
#       else
#         @post = @item
#       end
#       redirect_to @item
#     end
#
#   end
#
#   # PUT /comments/1
#   # PUT /comments/1.xml
#   def update
#     @comment = @item.comments.find(params[:id])
#
#     respond_to do |format|
#       if @comment.update_attributes(params[:comment])
#         flash[:notice] = 'Comment was successfully updated.'
#         format.html { redirect_to([@item, @comment]) }
#         format.xml  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /comments/1
#   # DELETE /comments/1.xml
#   def destroy
#     @comment = @item.comments.find(params[:id])
#     @comment.destroy
#
#     respond_to do |format|
#       format.html { redirect_to(post_comments_url(@item)) }
#       format.xml  { head :ok }
#     end
#   end
# end
