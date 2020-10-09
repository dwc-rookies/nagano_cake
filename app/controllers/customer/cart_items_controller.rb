class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(product_id: params[:cart_item][:product_id]).present?
      cart_item = current_customer.cart_items.find_by(product_id: params[:cart_item][:product_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.save
      flash[:notice] = "Item was successfully added to cart."
      redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice] = "You have creatad cart_item successfully."
      redirect_to cart_items_path
    else
      redirect_back(fallback_location: products_path)
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def delete_all
		@cart_items = current_customer.cart_items
		@cart_items.delete_all
    redirect_to cart_items_path
  end

private

def cart_item_params
  params.require(:cart_item).permit(:quantity, :product_id, :customer_id)
end

end