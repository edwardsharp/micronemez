class PlaylistsController < ApplicationController
  
  caches_page :index

  def index
  	#TODO: limit scope to attributes actually used in the view
  	@videos = Video.order('created_at ASC').all
  	@audios = Audio.order('created_at ASC').all
  end

end
