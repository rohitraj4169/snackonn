class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :params
  
  def some_method
    user = User.find_by(email: params[:user][:email])
    if user && user.role == "admin"
      super
    else
      # handle non-admin user
    end
  end
end