class TopicsController < ApplicationController  
  
  before_filter :authenticate_user!, :except => [:index, :show]

  def show
    @topic = Topic.find(params[:id])
    @topic.hit! if @topic
  end
  
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.new
  end
  
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.build(params[:topic])
    @topic.user = current_user
    
    if @topic.save
      flash[:notice] = "CREATED!"
      redirect_to topic_url(@topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    
    if @topic.update_attributes(params[:topic])
      flash[:notice] = "UPDATED!"
      redirect_to topic_url(@topic)
    end
  end

  def destroy
    authenticate_user!
    @topic = Topic.find(params[:id])
    
    if @topic.destroy
      flash[:notice] = "DELETED!"
      redirect_to forum_url(@topic.forum)
    end
  end
end
