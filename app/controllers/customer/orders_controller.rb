class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_item_check,{only: [:new, :confirm, :create]}

  def index
    @orders = current_customer.orders.order(created_at: "DESC")
  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = OrderedProduct.where(order_id: @order.id)
    if @order.customer.id != current_customer.id
      redirect_to orders_path
    end
  end

  def new
    @order = Order.new
    @delivery = Delivery.new
  end

  def confirm
    @order =  current_customer.orders.build(order_params)
    @cart_items = current_customer.cart_items
    if request.post? then
      if params[:order][:pay] == "credit_card"
        @pay = "クレジットカード"
      else
        @pay = "銀行振込"
      end
    end
    session[:new_delivery] = nil
    case params[:delivery_address_type]
    when "ご自身の住所"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "登録済み住所から選択"
      @order.postcode = Delivery.find(set_delivery[:id]).postcode
      @order.address = Delivery.find(set_delivery[:id]).address
      @order.name = Delivery.find(set_delivery[:id]).name
    when "新しいお届け先"
      if @order.postcode.blank? or @order.address.blank? or @order.name.blank?
        @order = Order.new
        @delivery = Delivery.new
        flash.now[:error]="入力内容に誤りがあります。"
        render 'new'
      else
        session[:new_delivery] = true
        @delivery = Delivery.new
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items

    if @order.save
      current_customer.cart_items.each do |ordered_product|
      @ordered_product = OrderedProduct.new(
        order_id: @order.id,
        product_id: ordered_product.product.id,
        purchase_money: ordered_product.product.tax_excluded_price,
        quantity: ordered_product.quantity,
        )
        @ordered_product.save!
      end

    if session[:new_delivery]
      @delivery = Delivery.new(
        customer_id: current_customer.id,
        postcode: @order.postcode,
        address: @order.address,
        name: @order.name
      )
      @delivery.save
      session[:new_delivery] = nil
    end

  else
    @order = Order.new
    @delivery = Delivery.new
    flash.now[:error]="入力内容に誤りがあります。"
    render 'new'
  end
    @cart_items.destroy_all
    session[:order_completed] = true
    redirect_to order_completed_path
  end

  def complete
    if session[:order_completed] 
      session[:order_completed] = nil
      flash.[:notice]="注文が完了しました。"
    else
      redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:pay, :postcode, :address, :name, :postage, :charge, :customer_id)
  end

  def set_delivery
    params.require(:order).require(:delivery).permit(:id)
  end

  def cart_item_check
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end
