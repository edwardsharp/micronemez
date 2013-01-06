class HexxController < ApplicationController
  

  def index
  	
  	#@schedule = Schedule.find(:all, :conditions => ["STRFTIME('%d', end) = ? AND STRFTIME('%m', end) = ?", Date.today.day, Date.today.month])

  	@live_now = Schedule.live_now.count ? Schedule.live_now  : nil


  	@upcoming_this_month = Schedule.upcoming_this_month.first ? Schedule.upcoming_this_month.first : nil


  end

  #TODO: implemnet AJAX-Y methodz...


end
