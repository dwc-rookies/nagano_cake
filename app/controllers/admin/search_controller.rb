class Admin::SearchController < ApplicationController

  def search
    @products = Product.search(params[:search])
    @customers = Customer.search(params[:search])
  end

end
