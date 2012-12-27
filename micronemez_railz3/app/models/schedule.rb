class Schedule < ActiveRecord::Base

	def datespan
		@datespan = date_writer(self.start.to_s, self.end.to_s)
	end

private
	def date_writer(startdatetime, enddatetime)
  	begin
  		_startdatetime = DateTime.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%a, %b %e, %Y from %l:%M%P") 
  		_enddatetime = DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%l:%M%P") 
      _totalminutes = ((DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").to_time - DateTime.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC").to_time)/60).to_i
  	rescue
  		return "SORRY"
	  end 
    #if on the same day just show the time difference.
  	startdate = Date.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC")
  	enddate = Date.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC")
  	unless startdate == enddate 
  		_enddatetime = DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%a, %b %e, %Y, %l:%M%P ") 
  	end
  	#TODO: translation ready plz: http://guides.rubyonrails.org/i18n.html#translations-for-active-record-models
  	return "#{_startdatetime} until #{_enddatetime} (#{_totalminutes}minz)"
  end 

end
