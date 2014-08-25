class Admin::CashesController < Admin::BaseController
  
  has_scope :page, :default => 1
  
  def create
    create! { admin_cashes_path }
  end
  
  def destroy
    destroy! { admin_cashes_path }
  end
  def update
    update! { admin_cashes_path}
  end
  
  def index
    @cashes = Cash.order('created_at DESC').page(params[:page]).per(20)
  end
  
  protected
  
  def permitted_params
    params.permit(:cash => [:source, :title, :link_url, :content, :order, :image, :hidden])
  end
end