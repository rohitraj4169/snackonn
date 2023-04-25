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
 
   def order_params
    params.require(:order).permit(:user_id, order_items[])
  end
end