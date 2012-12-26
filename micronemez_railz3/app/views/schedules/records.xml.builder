xml.instruct! :xml, :version=>"1.0" 

xml.tag!("data") do #actual count of records need to be used here
	@records.each do |record|
		xml.tag!("event",{ "id" => record.id }) do
			xml.tag!("text", record.title)
			xml.tag!("start_date", record.start)
			xml.tag!("end_date", record.end)

      #xml.tag!("event_pid", record.event_pid)
      xml.tag!("event_length",record.event_length)
      xml.tag!("rec_pattern",record.rec_pattern)
      xml.tag!("rec_type",record.rec_type)
      
      xml.tag!("single_checkbox",record.single_checkbox)
      xml.tag!("radiobutton_option",record.radiobutton_option)
      xml.tag!("type",record.custom_type)
      #xml.tag!("",record.)
		end
	end
end