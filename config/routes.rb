Icewhistle::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :crumbles do
    resources :comments
    collection do
      get :by_date
    end
  end
  resources :blogimages
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  resources :publications
  match '/contact' => "contact#index", via: :get
  resources :projects
  resources :search
  match '/admin' => "admin/posts#index", via: :get
  resources :feeds, :format => 'rss'
  match '/agg' => "feeds#agg", via: :get
  resources :tags
  # connect 'xmlrpc/api', :controller => 'xmlrpc', :action => 'api'
  
  resources :categories
  resources :links
  resources :skills

   # connect 'account/:action', :controller => 'account', :action => :action
  # match 'contact' => 'contact#new', :as => 'contact', :via => :get
  resources :contact
  # match '/contact' => 'contact#create', :as => 'contact', :via => :post
  match '/cv', :controller => 'cv', :action => :index, via: :get
  root :controller => :frontpage, :action => :index
  resources :posts do 
    resources :comments
  end
  # connect 'posts/tag', :controller => 'posts', :action => 'tag'
  # connect 'reblog', :controller => 'groupings', :id => '3', :action => 'show'
  # connect 'reblog.rss', :controller => 'groupings', :id => '3', :action => 'show', 'format' => 'rss'
  resources :groupings, :has_many => 'posts'
  resources :tags, :has_many => 'posts'
  resources :search
  namespace :admin do 
    resources :crumbles
    resources :cashes
    resources :schools
    resources :jobs
    resources :links
    resources :skills
    resources :projects
    resources :posts
    resources :publications
    resources :groupings
  end


end
