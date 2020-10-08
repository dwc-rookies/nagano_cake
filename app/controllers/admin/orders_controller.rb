class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @order = Order.all.order(created_at: "DESC")
  end

  def show
  end

  def update
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
