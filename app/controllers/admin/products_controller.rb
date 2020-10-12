class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @products = Product.page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "You have creatad product successfully."
      redirect_to admin_product_path(@product.id)
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "You have updated product successfully."
      redirect_to admin_product_path(@product.id)
    else
      render 'edit'
    end
  end

private

def product_params
  params.require(:product).permit(:name, :tax_excluded_price, :description, :image, :is_active, :genre_id)
end

end
