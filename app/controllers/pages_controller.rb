class PagesController < ApplicationController
  before_action :categories_id, only: %i[ index categories_index product_detail product_index ]
  before_action :current_cart
  def index
  @products = Product.all
  end

  def customers
    @customers = User.where(role_id: 2)
  end
  # def categories_index
  
  #   @categories = Category.find(params[:id])
    
  # end

  def categories_index
    
    @categories_products = Category.find(params[:id])
    
  end
  def product_detail
    @products_detail = Product.find(params[:id])
  end

  def product_index
    @ransack_product = Product.ransack(params[:products_search], search_key: :products_search)
    @product_index =@ransack_product.result(distinct: true)
  end


  private
  def categories_id
    @categories = Category.all
  end
  



 















end
