class SchedulesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :show, :records, :dbaction]
  #TODO: fix this!
  skip_before_filter :verify_authenticity_token, :dbaction

  #GET
  def records
    #TODO: limit this?
    @records = Schedule.find(:all, :order => "start ASC", :limit => "250")
    respond_to do |format|
      format.xml # index.html.rxml
      format.json { render json: @schedules }
    end
  end
  

  def dbaction
    #@records = Schedule.all
    #called for all db actions
    text = params["text"]
    start_date = params["start_date"]
    end_date = params["end_date"]   

    event_length = params["event_length"]
    rec_pattern = params["rec_pattern"]
    rec_type = params["rec_type"]

    single_checkbox = params["single_checkbox"]
    radiobutton_option = params["radiobutton_option"]
    custom_type = params["type"]

    @mode = params["!nativeeditor_status"]
    @id = params["id"]
    @tid = @id
    
    case @mode
      when "inserted"
        n_rec = Schedule.new
        n_rec.title = text
        n_rec.start = start_date
        n_rec.end = end_date
        n_rec.event_length = event_length
        n_rec.rec_pattern = rec_pattern
        n_rec.rec_type = rec_type
        n_rec.single_checkbox = single_checkbox
        n_rec.radiobutton_option = radiobutton_option
        n_rec.custom_type = custom_type

        n_rec.save!
        
        @tid = n_rec.id
      when "deleted"
        n_rec=Schedule.find(@id)
          n_rec.destroy
      when "updated"
        n_rec=Schedule.find(@id)
        n_rec.title = text
        n_rec.start = start_date
        n_rec.end = end_date
        n_rec.event_length = event_length
        n_rec.rec_pattern = rec_pattern
        n_rec.rec_type = rec_type
        n_rec.single_checkbox = single_checkbox
        n_rec.radiobutton_option = radiobutton_option
        n_rec.custom_type = custom_type

        n_rec.save!
    end

    respond_to do |format|
      format.xml # index.html.rxml
      format.json { render json: @id }
    end

  end


  # GET /schedules
  # GET /schedules.json
  def index
    #@schedules = Schedule.find(:all, :conditions => ["start > ?", DateTime.now], :order => "start ASC", :limit => "250")
    @schedules = Schedule.paginate(
      :conditions => ["end > ?", DateTime.now], 
      :page => params[:page], 
      :per_page => 2, 
      :order => "start ASC" )
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/new
  # GET /schedules/new.json
  def new
    authenticate_user!
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

  # GET /schedules/1/edit
  def edit
    authenticate_user!
    @schedule = Schedule.find(params[:id])
  end

  # POST /schedules
  # POST /schedules.json
  def create
    authenticate_user!
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    authenticate_user!
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    authenticate_user!
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
  end
end
