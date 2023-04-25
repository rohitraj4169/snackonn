module ApplicationHelper
    include Pagy::Frontend
   def redirect_to_path
    if user_signed_in? && current_user.role_id == 1
      admins_path
    else
      customers_path
    end
  end
end
