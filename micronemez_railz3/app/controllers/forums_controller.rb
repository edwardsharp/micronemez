class ForumsController < ApplicationController    
  
  before_filter :authenticate_user!, :except => [:index, :show]

  def show
    @forum = Forum.find(params[:id])
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(params[:forum])
    
    if @forum.save
      flash[:notice] = "CREATED!"
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum = Forum.find(params[:id])
  end
  
  def update
    @forum = Forum.find(params[:id])
    
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "UPDATED!"
      redirect_to forum_url(@forum)
    end
  end
  
  def destroy
    @forum = Forum.find(params[:id])
    
    if @forum.destroy
      flash[:notice] = "OHNOZ! DELETED!"
      redirect_to forums_url
    end
  end
end