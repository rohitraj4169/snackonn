class LineItemsController < ApplicationController
#  before_action :set_cart
before_action :current_cart
# first start
# def create
#   # Find associated product and current cart
#   chosen_product = Product.find(params[:product_id])
#   current_cart = @current_cart

#   # If cart already has this product then find the relevant line_item and iterate quantity otherwise create a new line_item for this product
#   if current_cart.products.include?(chosen_product)
#     # Find the line_item with the chosen_product
#     @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
#     # Iterate the line_item's quantity by one
#     @line_item.quantity += 1
#   else
#     @line_item = LineItem.new
#     @line_item.cart = current_cart
#     @line_item.product = chosen_product
#     @line_item.quantity = 1
#   end

#   # Save and redirect to cart show path
#   @line_item.save
#   redirect_to cart_path(current_cart)
# end
#  first end
# second start
def create

  # Find associated product and current cart
  chosen_product = Product.find(params[:product_id])
  current_cart = @current_cart

  if user_signed_in?
    # If user is logged in, use Rails session to store cart data
    if current_cart.products.include?(chosen_product)
      # Find the line_item with the chosen_product
      @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
      # Iterate the line_item's quantity by one
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.product = chosen_product
      @line_item.quantity = 1
    end

    # Save and redirect to cart show path
    @line_item.save
    # redirect_to cart_path(current_cart)
    redirect_to root_path, notice: "Added to Cart"
  else
    # If user is not logged in, use local storage to store cart data
    addToCart(chosen_product.id, chosen_product.price, 1)
    # redirect_to products_path
    redirect_to cart_path, notice: 'Item added to cart'
  end
end

# second end
def add_quantity
  @line_item = LineItem.find(params[:id])
  @line_item.quantity += 1
  @line_item.save
  redirect_to cart_path(@current_cart)
end

def reduce_quantity
  @line_item = LineItem.find(params[:id])
  if @line_item.quantity > 1
    @line_item.quantity -= 1
  end
  @line_item.save
  redirect_to cart_path(@current_cart)
end

def destroy
  @line_item = LineItem.find(params[:id])
  @line_item.destroy
  redirect_to cart_path(@current_cart), notice: 'Item was successfully removed from your cart.'
end  
private
  def line_item_params
    params.require(:line_item).permit(:quantity,:product_id, :cart_id)
  end
end
