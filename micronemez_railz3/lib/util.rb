  #date_writer("2012-12-29 08:20:00 UTC", "2012-12-29 20:40:00 UTC")
    	#test
  	#startdatetime="2012-12-29 08:20:00 UTC"
  	#enddatetime="2012-12-29 20:40:00 UTC"
  	#TODO: flag arg? %c = %a %b %e %T %Y
  	  		#TODO: begin/rescue so the template doesnot barf when the format changez for whatever reason...
 
  def date_writer(startdatetime, enddatetime)
  	begin
  		_startdatetime = DateTime.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%a, %b %e, %Y from %I:%M%P") 
  		_enddatetime = DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%I:%M%P") 
      _totalminutes = ((DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").to_time - DateTime.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC").to_time)/60).to_i
  	rescue
  		return "SORRY"
	  end 
    #if on the same day just show the time difference.
  	startdate = Date.strptime(startdatetime,"%Y-%m-%d %H:%M:%S UTC")
  	enddate = Date.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC")
  	unless startdate == enddate 
  		_enddatetime = DateTime.strptime(enddatetime,"%Y-%m-%d %H:%M:%S UTC").strftime("%a, %b %e, %Y, %I:%M%P ") 
  	end

  	return "#{_startdatetime} #{t :enddatetime_prefix} #{_enddatetime} (#{_totalminutes} #{t :datetime_totalminutes})"

  end 