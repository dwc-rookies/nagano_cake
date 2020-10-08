class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @orders = Order.all.order(created_at: "DESC")
  end

  def show
    @order = Order.find(params[:id])
    @ordered_product = OrderedProduct.all.includes(:rooms)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "You have updated order successfully."
    redirect_back(fallback_location: admin_orders_path)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
