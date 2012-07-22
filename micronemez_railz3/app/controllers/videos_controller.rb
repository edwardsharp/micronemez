class VideosController < ApplicationController
  
  #autocomplete :video, :name, :full => true, :class_name => 'ActsAsTaggableOn::Tag'
  
  # GET /videos/new
  # GET /videos/new.json
  def new
    authenticate_user!
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    authenticate_user!
    @video = Video.find(params[:id])

    # tag list parsing string->json 
    # this is voodoo but we need to turn something that looks like this:
    # foo, bar, baz 
    # into this: 
    # [{"id":0,"name":"foo"},{"id":1,"name":" bar"},{"id":2,"name":" baz"}
    
    #tags = @video.tag_list.to_s
    @tags = stringToJsonHash(@video.tag_list.to_s)
    

    yell "tagZ: #{@tags}"
  end

  # POST /videos
  # POST /videos.json
  def create
    authenticate_user!
    #p params[:video]
    @video = Video.create params[:video]
    
    respond_to do |format|
      if @video.save
        cookies[:last_video_id] = @video.id 
        #Delayed::Job.enqueue(FileUploadJob.new(@video.id, @video.path), -3, 3.days.from_now)

        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render json: @video, status: :created, location: @video }
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    authenticate_user!
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes params[:video]
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    authenticate_user!
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
  
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # # # # # #
  # A J A X #
  # # # # # #
  
  def tags
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%") 
    #@tags = Video.tag_counts(:limit => 50, :order => "count desc")
    #@tags = Video.tag_counts_on(:tag, :limit => 50, :order => "count desc")
    @out = @tags.map{|b| {:id => b.id, :name => b.name }}
    

    
    respond_to do |format|
      format.json { render :json => @out }
    end

  end
  
  def newtag
    #@newtag = stringToJsonHash(params[:q].to_s)
    @newtag = params[:q].to_json
    yell "NEWtag #{@newtag}"
    respond_to do |format|
      format.json { render :json => @newtag }
    end
  end
  
  #@SuppressWarnings("unused")
  def live_search
    @videos = Video.find_latest params[:q]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @videos }
    end
    
    render :layout => false
  end
  
end
