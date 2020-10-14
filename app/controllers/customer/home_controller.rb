class Customer::HomeController < ApplicationController

  def top
    genres = Genre.where(is_active: true)
    genre_true=[]
    i=0
    genres.each do |genre|
      genre_true.push(genres[i][:id])
      i+=1
    end
    @products = Product.where(genre_id: genre_true)
    @products = @products.where(is_active: true).order(created_at: "DESC")
    @genres = Genre.where(is_active: true)

    # @genres = Genre.where(is_active: true)
    #   genre_id = params[:genre_id]
    #   if genre_id.present?
    #     @products = @products.where(genre_id: genre_id)
    #   end  
  end

  def about
  end

end

