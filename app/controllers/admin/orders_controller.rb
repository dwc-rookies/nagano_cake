class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    # @orders = Order.all.order(created_at: "DESC")
    # 会員詳細ページから遷移した場合はその会員の注文データを表示する。
    order_check = params[:order_check].to_i # 会員詳細ページからのlink_toメソッドには会員idを付加している。
    if order_check >= 1
      @orders = Order.where(customer_id: order_check)
    else
      @orders = Order.all
    end
    @orders = @orders.page(params[:page]).per(10).order(created_at: "DESC")
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
    flash.now[:notice] = "注文ステータスを更新しました。"
    @update_order = true
    render 'show'
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
