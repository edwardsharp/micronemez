class VideoController < ApplicationController
  
  # keep it simple, eh?

  def index
  end

  def show
  	@video = Video.find_by_catnum(params[:catnum]) 
  	@video ||= Video.find(params[:catnum]) 

  end

end
