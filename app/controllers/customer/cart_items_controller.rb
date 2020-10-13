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
      flash[:notice] = "カート内商品の個数を追加しました。"
      redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice] = "カートに新しい商品を追加しました。"
      redirect_to cart_items_path
    else
      redirect_back(fallback_location: products_path)
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash.now[:notice]="商品の個数を変更しました。"
    else
      flash.now[:error]="入力内容に誤りがあります。"
    end
    @update_cart_items = @cart_item.id
    @cart_items = current_customer.cart_items
    render 'index'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice]="商品を削除しました。"
    redirect_to cart_items_path
  end

  def delete_all
		@cart_items = current_customer.cart_items
    @cart_items.delete_all
    flash[:notice]="商品を全て削除しました。"
    redirect_to cart_items_path
  end

private

def cart_item_params
  params.require(:cart_item).permit(:quantity, :product_id, :customer_id)
end

end