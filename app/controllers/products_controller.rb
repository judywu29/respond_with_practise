class ProductsController < ApplicationController
  
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    respond_with(@products)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    respond_with(@product)
  end

  # GET /products/new
  def new
    @product = Product.new
    respond_with(@product)
  end

  # GET /products/1/edit
  def edit
    respond_with(@product)
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    
    if @product.save
      flash[:notice] = 'Product was successfully created.'
    end
    respond_with(@product)
      
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    
     if @product.update(product_params)
       flash[:notice] = 'Product was successfully updated.'
     end
    respond_with(@product)
   
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name)
    end
end
