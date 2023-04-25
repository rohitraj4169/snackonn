class ApplicationController < ActionController::Base
    layout :choose_layout
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_global_variables

   protect_from_forgery with: :exception

    include Pagy::Backend  
    def set_global_variables
      @ransack_product = Product.ransack(params[:products_search], search_key: :products_search)
    end
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :address_line_1, :address_line_2, :city, :state, :country, :pincode, :role_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :address_line_1, :address_line_2, :city, :state, :country, :pincode, :role_id])
  end


  # def set_cart
  #   if user_signed_in?
  #     @current_cart = current_user.cart
  #   else
  #     @current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
  #     session[:cart_id] = @current_cart.id
  #   end
  # end
   helper_method :current_cart
   def current_cart
    if user_signed_in?
      @current_cart ||= current_user.cart || Cart.create(user_id: current_user.id)
    else
      @current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
      session[:cart_id] = @current_cart.id
    end
    # end

  end
  #   else
  #     if session[:cart_id]
  #       cart = Cart.find_by(id: session[:cart_id])
  #       if cart.present?
  #         @current_cart = cart
  #       else
  #         session[:cart_id] = nil
  #       end
  #     end

  #     if session[:cart_id].nil?
  #       @current_cart = Cart.create(user_id: 1) #Cart.create
  #       session[:cart_id] = @current_cart.id
  #     end
  #   end
  # end

  
  
  def choose_layout
    if current_user && (current_user.role_id==1)
      'admin.html.erb'
    elsif current_user&& (current_user.role_id==2)
      'customer.html.erb'
    else
      'customer.html.erb'
    end
  end



end
