class Customer::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
  end

  def create
  end

  def update
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def delete_all
		@cart_items =  current_customer.cart_items
		@cart_items.delete_all
    redirect_to cart_items_path
  end

private

def cart_params
  params.require(:cart).permit(:quantity,:product_id)
end

end