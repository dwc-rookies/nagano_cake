class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
  end

  def show
  end

  def new
    @order = Order.new
    @delivery = Delivery.new 
  end

  def create
  end

  def confirm
    @cart_items = current_customer.cart_items
  end

  def complete
  end

end
