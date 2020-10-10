class Customer::OrdersController < ApplicationController

  def index
  end

  def show
  end

  def new
    @order = Order.new
    @delivery = Delivery.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
  end

  def create
  
  end



  def complete
  end

  private

   def order_params
     params.require(:order).permit(:pay, :postcode, :address, :name)
   end


end
