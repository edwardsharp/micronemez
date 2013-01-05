class HexxController < ApplicationController
  

  def index
  	
  	#@schedule = Schedule.find(:all, :conditions => ["STRFTIME('%d', end) = ? AND STRFTIME('%m', end) = ?", Date.today.day, Date.today.month])

  	@live_now = Schedule.live_now

  	@upcoming_this_month = Schedule.upcoming_this_month.first


  end

  #TODO: implemnet AJAX-Y methodz...


end
