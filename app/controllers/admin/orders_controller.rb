class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    # @orders = Order.all.order(created_at: "DESC")
    @orders = Order.page(params[:page]).per(5).order(created_at: "DESC")
  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = OrderedProduct.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    # 注文ステータスを入金確認にしたら、制作ステータスを制作待ちにする。
    @ordered_products = OrderedProduct.where(order_id: @order.id)
    if @order.status == 1
      @ordered_products.each do |ordered_product|
        ordered_product.update(production_status: 1)
      end
    end
    flash[:notice] = "You have updated order successfully."
    redirect_back(fallback_location: admin_orders_path)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
