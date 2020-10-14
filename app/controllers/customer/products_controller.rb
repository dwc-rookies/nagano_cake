class Customer::ProductsController < ApplicationController

  def index
    genres = Genre.where(is_active: true)
    genre_true=[]
    i=0
    genres.each do |genre|
      genre_true.push(genres[i][:id])
      i+=1
    end
    @products = Product.where(genre_id: genre_true)
    @products = @products.where(is_active: true)
    @genres = Genre.where(is_active: true)

    genre_id = params[:genre_id] #ジャンル検索用のlink_toメソッドには、ジャンルidパラメータを付加している。
    if genre_id.present? #もしジャンルidパラメータが存在するなら、そのジャンルの製品のみを抽出する。
      @products = @products.where(genre_id: genre_id)
      genre = Genre.find(genre_id)
      @genre_name = genre.name
    else
      @genre_name = '商品'
    end
    @products_count = @products.count
    @products = @products.page(params[:page]).per(8)
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.where(is_active: true)
    if @product.is_active == false or @product.genre.is_active == false
      redirect_to products_path
    end
  end

end
