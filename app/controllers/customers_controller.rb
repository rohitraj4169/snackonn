class CustomersController < ApplicationController

  # layout 'customer'

  # def index
  #   @categories = Category.all
  #   # Other code for the index action
  # end

  # before_action :set_customer_category, only: %i[ show]
  # before_action :set_customer_product, only: %i[ show]

  # def customer_categories_index
  #   # @ransack_category = Category.ransack(params[:categories_search], search_key: :categories_search)
  #   # @pagy, @categories = pagy(@ransack_category.result(distinct: true))
  #   @categories = @ransack_category.result
  # end

  # def customer_categories_show
  # end

   

  # def customer_products_index
  #   @categories = Category.all
  #   if params[:category_id]
  #     @products = Product.where(category_id: params[:category_id])
  #     @pagy, @products = pagy(@products, items: 5)
  #   else
  #     @ransack_product = Product.ransack(params[:products_search], search_key: :products_search)
  #     @pagy, @products = pagy(@ransack_product.result(distinct: true), items: 5)
  #   end
  #     if params[:page].present? && params[:page].to_i > @pagy.last
  #       redirect_to products_path(page: @pagy.last) and return
  #     end
    
  # end


  # def customer_products_show
  # end

  

  # private
    
  #   def set_customer_category
  #     @category = Category.friendly.find(params[:id])
  #   end
  #   def set_customer_product
  #     @product = Product.friendly.find(params[:id])
  #   end

   



end
