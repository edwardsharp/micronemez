class HomeController < ApplicationController
  def index
  	#TODO: limit scope to attributes actually used in the view
  	@videos = KalturaVideo.order('updated_at ASC').all
  	@audios = KalturaAudio.find(:all)
  end

end
