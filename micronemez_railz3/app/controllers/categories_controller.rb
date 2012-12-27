class CategoriesController < ApplicationController  
  
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    
    if @category.save
      flash[:notice] = "CREATED!"
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    
    if @category.update_attributes(params[:category])
      flash[:notice] = "UPDATED!"
      redirect_to forums_url
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    
    if @category.destroy
      flash[:notice] = "DELETED!"
      redirect_to forums_url
    end
  end
end