class CartsController < ApplicationController
    # before_action :set_cart
    before_action :current_cart
  def show
    @categories = Category.all
    @cart = @current_cart
  end

  def destroy
    # cartId=@current_cart.id
    @current_cart.line_items.each do |line_item|
      line_item.destroy
    end
    redirect_to root_path
  end

  
  def local_cart
    cart_data = []
    @current_cart.line_items.each do |line_item|
      cart_data.push(line_item)
    end

    localStorage.setItem("order", cart_data.to_json)
  end



end