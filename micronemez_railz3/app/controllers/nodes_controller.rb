class NodesController < ApplicationController

	before_filter :authenticate_admin!, :except => [:index, :show, :tags]

  autocomplete :node, :name, :full => true, :class_name => 'ActsAsTaggableOn::Tag'

  # GET /nodes
  # GET /nodes.json
  def index
    #@nodes = Node.all
    @nodes = Node.paginate(
      #:conditions => ["updated_at > ?", DateTime.now], 
      :page => params[:page], 
      :per_page => 2, 
      :order => "updated_at ASC",)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    @node = Node.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/new
  # GET /nodes/new.json
  def new
    @node = Node.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @node }
    end
  end

  # GET /nodes/1/edit
  def edit
    @node = Node.find(params[:id])
    @tags = stringToJsonHash(@node.tag_list.to_s)
    
    yell "tagZ: #{@tags}"
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(params[:node])

    respond_to do |format|
      if @node.save
        cookies[:last_node_id] = @node.id 
        format.html { redirect_to @node, notice: 'node created!' }
        format.json { render json: @node, status: :created, location: @node }
      else
        format.html { render action: "new" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.json
  def update
    @node = Node.find(params[:id])

    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :ok }
    end
  end

  # # # # # #
  # A J A X #
  # # # # # #
  
  def tags
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%") 
    #@tags = Node.tag_counts(:limit => 50, :order => "count desc")
    #@tags = Node.tag_counts_on(:tag, :limit => 50, :order => "count desc")
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
    @nodes = Node.find_latest params[:q]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nodes }
    end
    
    render :layout => false
  end


end
