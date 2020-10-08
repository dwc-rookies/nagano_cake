class Admin::OrderedProductsController < ApplicationController
  before_action :authenticate_admin_admin!

  def update
  end

  private

  def ordered_product_params
    params.require(:ordered_product).permit(:production_status)
  end

end
