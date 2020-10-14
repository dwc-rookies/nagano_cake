class Customer::HomeController < ApplicationController

  def top
    @products = Product.all
    # @genres = Genre.where(is_active: true)
    #   genre_id = params[:genre_id]
    #   if genre_id.present?
    #     @products = @products.where(genre_id: genre_id)
    #   end  
  end

  def about
  end

end

