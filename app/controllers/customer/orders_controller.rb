class Customer::OrdersController < ApplicationController

  def index
  end

  def show
  end

  def new
    @order = Order.new
    @order_customer = Customer.find(current_user.id)
  end

  def create
  end

  def confirm
  end

  def complete
  end

end
