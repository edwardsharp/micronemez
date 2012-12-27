Micronemez::Application.routes.draw do
  
  resources :categories, :except => [:index, :show]
  resources :forums, :except => :index do
    resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'categories#index', :via => :get
  end

  get "hexx/index"


  match "/info" => "pages#info", :as => "info"
  match "/info/:ajax" => "pages#info", :as => "info_ajax"
  match "/archives/:ajax" => "videos#index", :as => "archive_ajax"
  match "/schedules/:ajax" => "schedules#index", :as => "schedule_ajax"
  match "/nodes/:ajax" => "nodes#index", :as => "nodes_ajax"

  #dhtmlxscheduler matchez
  match "/schedules/records" => "schedules#records"
  match "/schedules/dbaction" => "schedules#dbaction"
  resources :schedules

  ## ##iscomingsoon!
  #this needs to come before the resource definition
  get "video/tags" => "videos#tags", :as => :tags
  post "video/tags" => "videos#newtag", :as => :tags
  #this is not the video name, rather for the video tag tags
  resources :videos do
    get :autocomplete_video_name, :on => :collection 
    
  end 
  
  #TODO: q: can this be refactored into the resources method? 
  # a: kindof particular here b/c having a convience :as method 
  # named :tags DRYz up the controller code...
  get "node/tags" => "nodes#tags", :as => :tags
  post "node/tags" => "nodes#newtag", :as => :tags
  resources :nodes do
    get :autocomplete_node_name, :on => :collection 
    #TODO: (above)
    #get :tags
    #post :tags
  end 

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  match "/admin" => "admin/base#index", :as => "admin"
  namespace "admin" do
    resources :users
  end

	#resources :videos, except => [:index]
	#resources :videos, :only => [:new, :create, :edit, :destroy]
  
  #segmentz
  ##controller :videos do
  ##  scope '/videos', :name_prefix => 'video' do
  ##    match 'show/:mediaId', :to => :kaltura_mediaId
      #scope :path => '/:title', :title => /[a-z]+/, :as => :with_title do  
      #end
  ##  end
  ##end
  
  match "/video/show/:entry_id" => "video#show", :as => "video"
  
  root :to => "hexx#index"

end
