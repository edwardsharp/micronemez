Micronemez::Application.routes.draw do
  
  match "/info" => "pages#info", :as => "info"
  
  ## ##iscomingsoon!
  #this needs to come before the resource definition
  get "video/tags" => "videos#tags", :as => :tags
  post "video/tags" => "videos#newtag", :as => :tags
  #this is not the video name, rather for the video tag tags
  resources :videos do
    get :autocomplete_video_name, :on => :collection 
    
  end 
  
  get "node/tags" => "nodes#tags", :as => :tags
  post "node/tags" => "nodes#newtag", :as => :tags
  resources :nodes do
    get :autocomplete_node_name, :on => :collection 
    
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
  
  root :to => "home#index"

end
