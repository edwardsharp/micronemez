class Schedule < ActiveRecord::Base

#handy/dandy named scopes here, can run thingz like Schedule.live_now and Schedule.upcoming_this_month and whatnot 
# butjesusfuck is that utf_offset annoying! #TODO: better time parsing?
scope :live_now, lambda { 
  #where("start <= ? AND end >= ?", Time.now.to_s(:db), Time.now.to_s(:db))
  #where("start between ? and ?", Time.now+Time.now.utc_offset, Time.now+Time.now.utc_offset)

  #array difference, subracting the false positives we get from the repeating schedule functionality
  onlypublic.before.after - account_for_repeating
} 
scope :before, lambda { where("start <= ?", Time.now.to_s(:db)) }

scope :after, lambda { where("end >= ?", Time.now.to_s(:db)) }

scope :account_for_repeating, lambda { 

  #need to double check reoccuring eventz for percision.
  # find records that do not match the day pattern...
  # & find records that DO NOT fit in the the hour timeframe of today so they can be subtracted from the array...
  account_for_repeating_hour#.account_for_repeating_day
}

scope :account_for_repeating_day, lambda {
    #TODO: fix this, rather buggy, workz fine in irb but when i run it i get a devide by zero error, resuce?
    #select{ |r| begin r.event_length != '' and  !(Time.now.day % r.rec_pattern.scan(/[0-9]/)[0].to_i) rescue r end }
    #select{ |r| r.event_length != '' and  !(Time.now.day % r.rec_pattern.scan(/[0-9]/)[0].to_i) }

}

scope :account_for_repeating_hour, lambda {
    select{ |r| r.event_length != '' and !((r.start.hour..(r.start+r.event_length.to_i).hour).cover?(Time.now.hour)) }

}

scope :onlypublic, lambda {
  #yeah, :public is a string!
  where(:single_checkbox=>:public)
}


scope :upcoming_this_month, lambda {
  onlypublic.where("end between ? and ?", Date.today, Date.today.next_month.beginning_of_month).order('start ASC')
}
 
scope :upcoming_this_year, lambda {
  onlypublic.where("start between ? and ?", Date.today, Date.today.next_year).order('start ASC')
} 

belongs_to :user
belongs_to :node

default_scope order 'start DESC'

  #unused?
  def live?(startdatetime, enddatetime)
    #if on the same day return TRUE.
    startdate = Date.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC")
    enddate = Date.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC")
    return (startdate..enddatetime).cover?(Time.now)
  end

  def upcoming_banner
     Schedule.live_now.collect {|s| s.title}
  end
	
  def datespan
		@datespan = date_writer(self.start.to_s, self.end.to_s)
	end

private
	def date_writer(startdatetime, enddatetime)
  	begin
  		_startdatetime = DateTime.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%a, %b %e, %Y %l:%M%P") 
  		_enddatetime = DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%l:%M%P") 
      _totalminutes = ((DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").to_time - DateTime.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC").to_time)/60).to_i
  	rescue => e
  		logger.info e.inspect
  		logger.info startdatetime
  		logger.info enddatetime
  		return "SORRY"
	  end 
    #if on the same day just show the time difference.
  	startdate = Date.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC")
  	enddate = Date.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC")
  	unless startdate == enddate 
  		_enddatetime = DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%a, %b %e, %Y, %l:%M%P") 
  	end
  	#TODO: translation ready plz: http://guides.rubyonrails.org/i18n.html#translations-for-active-record-models
  	return "#{_startdatetime}-#{_enddatetime} (#{_totalminutes}minz)"
  end 

end
