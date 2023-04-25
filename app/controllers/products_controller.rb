class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @categories = Category.all
    if params[:category_id]
      @products = Product.where(category_id: params[:category_id])
      @pagy, @products = pagy(@products, items: 5)
    else
      # @products = Product.all
      @ransack_product = Product.ransack(params[:products_search], search_key: :products_search)
      #  @pagy, @products = pagy(Product.all)
      #  @pagy, @products = pagy(@ransack_product.result.includes(:category))
      @pagy, @products = pagy(@ransack_product.result(distinct: true), items: 5)
    end
      if params[:page].present? && params[:page].to_i > @pagy.last
        redirect_to products_path(page: @pagy.last) and return
      end
    
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "category_id", "price", "stock", "status"] # add all the attributes you want to allowlist here
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :weight, :stock, :unit, :status, :image, :category_id)
    end
end
