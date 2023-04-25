class OrdersController < ApplicationController
  before_action :current_cart
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  # def step1
  #   @order = Order.new()
  # end

  def create
    cart_data = []
    @current_cart.line_items.each do |line_item|
        cart_data << { 
            product_id: line_item.product.id, 
            product_name: line_item.product.name.to_s, 
            quantity: line_item.quantity, 
            price: line_item.product.price.to_s,
            sub_total: (line_item.product.price * line_item.quantity).to_s
        }
    end

    sub_total = cart_data.sum { |item| item[:sub_total].to_f }
    
    @order = current_user.orders.build(order_items: cart_data, sub_total: sub_total)
 
    @order.address_data = {
    first_name: address_params[:first_name].to_s,
    last_name: address_params[:last_name].to_s,
    email: address_params[:email].to_s,
    mobile_number: address_params[:mobile_number].to_s,
    address1: address_params[:address1].to_s,
    address2: address_params[:address2].to_s,
    state: address_params[:state].to_s,
    city: address_params[:city].to_s,
    pincode: address_params[:pincode].to_s
    
  }
    if @order.save
        @current_cart.line_items.each do |line_item|
          line_item.destroy
        end
        redirect_to root_path, notice: "Order placed successfully!"
    else
        render :new
    end
end


private
 

# def order_params
#   params.require(:order).permit(:user_id, order_items: []).merge(
#     full_name: params[:order][:full_name],
#     mobile_number: params[:order][:mobile_number],
#     pincode: params[:order][:pincode],
#     state: params[:order][:state],
#     city: params[:order][:city],
#     address1: params[:order][:address1],
#     address2: params[:order][:address2]
#   )
# end

  def address_params
    params.require(:order).permit(:first_name,:last_name,:email, :mobile_number,:address1,:address2, :country,:state, :city, :pincode)
  end


end