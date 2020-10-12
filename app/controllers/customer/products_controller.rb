class Customer::ProductsController < ApplicationController

  def index
    @genres = Genre.where(is_active: true)
    @products = Product.where(is_active: true)
    genre_id = params[:genre_id] #ジャンル検索用のlink_toメソッドには、ジャンルidパラメータを付加している。
    if genre_id.present? #もしジャンルidパラメータが存在するなら、そのジャンルの製品のみを抽出する。
      @products = @products.where(genre_id: genre_id)
    end
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
    if @product.is_active == false or @product.genre.is_active == false
      redirect_to products_path
    end
  end

end
