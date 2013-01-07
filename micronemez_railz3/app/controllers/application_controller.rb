class ApplicationController < ActionController::Base
  protect_from_forgery

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end

	private  
  #fuck. i hope this doesn't ever run into another devise method someday, 
  # i mean i was really expecting this method to exist with the devise lib...
  def authenticate_admin! 
    redirect_to notanadmin_path unless current_user && current_user.admin?
  end

end
