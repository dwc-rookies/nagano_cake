class Admin::OrderedProductsController < ApplicationController
  before_action :authenticate_admin_admin!

  def update
    @ordered_product = OrderedProduct.find(params[:id])
    @ordered_product.update(ordered_product_params)
    flash[:notice] = "You have updated ordered_product successfully."
    redirect_back(fallback_location: admin_orders_path)
  end

  private

  def ordered_product_params
    params.require(:ordered_product).permit(:product_status)
  end

end
