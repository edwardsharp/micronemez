Micronemez::Application.routes.draw do
  
  #this needs to come before the resource definition
  get "video/tags" => "videos#tags", :as => :tags
  post "video/tags" => "videos#newtag", :as => :tags
  #this is not the video name, rather for the video tag tags
  resources :videos do
    #get :autocomplete_video_name, :on => :collection 
    
  end
  
  


  get "video/index"

  get "video/new"

  get "video/edit"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get "pages/index"

  match "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

	#resources :videos, except => [:index]
	#resources :videos, :only => [:new, :create, :edit, :destroy]
  
  #segmentz
  controller :videos do
    scope '/videos', :name_prefix => 'video' do
      scope :path => '/:title', :title => /[a-z]+/, :as => :with_title do 
        match '/:micronemezid', :to => :with_micronemezid
      end
    end
  end
  
  root :to => "home#index"

end
