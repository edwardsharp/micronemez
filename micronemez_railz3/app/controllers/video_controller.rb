class VideoController < ApplicationController
  
  # keep it simple, eh?

  def index
  end

  def show
  	@video = Video.find_by_catnum(params[:entry_id]) 
  	@video ||= Video.find(params[:entry_id]) 

  end

end
