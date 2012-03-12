class HomeController < ApplicationController
  def index
  	#TODO: limit scope to attributes actually used in the view
  	@videos = KalturaVideo.order('created_at DESC').all
  	@audios = KalturaAudio.find(:all)
  end

end
