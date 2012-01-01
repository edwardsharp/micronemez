class HomeController < ApplicationController
  def index
  	@videos = KalturaVideo.find(:all)
  end

end
