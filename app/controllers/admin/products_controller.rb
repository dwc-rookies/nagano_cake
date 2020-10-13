class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @products = Product.page(params[:page]).per(10)
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
      flash[:notice] = "新たな商品を登録しました。"
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
      flash[:notice] = "商品の内容を編集しました。"
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
