class Admin::SessionsController < Devise::SessionsController
  # layout :admin
  before_action :authenticate_user!, except: [:new, :create]
  
  def new
    if user_signed_in? && current_user.role_id == 1

    else
      self.resource = User.new
    end
    
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.role == "admin"
      super
    else
      flash[:alert] = "You are not authorized to access this page"
      redirect_to root_path
    end
  end
end
