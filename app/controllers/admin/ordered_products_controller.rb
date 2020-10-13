class Admin::OrderedProductsController < ApplicationController
  before_action :authenticate_admin_admin!

  def update
    ordered_product = OrderedProduct.find(params[:id])
    ordered_product.update(ordered_product_params)
    # 製品ステータスがいずれか「制作中」のとき → 注文ステータスを「制作中」にする。
    # 製品ステータスが全て「制作完了」のとき → 注文ステータスを「発送準備中」にする。
    case ordered_product.production_status
    when 2
      ordered_product.order.update(status: 2)
    when 3
      order = ordered_product.order
      ordered_products = OrderedProduct.where(order_id: order.id)
      if ordered_products.all?{|ordered_product| ordered_product.production_status == 3}
        ordered_product.order.update(status: 3)
      end
    end
    flash[:notice] = "製品ステータスを更新しました。"
    redirect_back(fallback_location: admin_orders_path)
  end

  private

  def ordered_product_params
    params.require(:ordered_product).permit(:production_status)
  end

end
