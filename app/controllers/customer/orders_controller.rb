class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = OrderedProduct.where(order_id: @order.id)
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
