class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @ordered_products = OrderedProduct.where(order_id: @order.id)
    if @order.id != current_customer.id
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

    case params[:delivery_address_type]
    when "ご自身の住所"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    when "登録済み住所から選択"
      @order.postcode = Delivery.find(set_delivery[:id]).postcode
      @order.address = Delivery.find(set_delivery[:id]).address
      @order.name = Delivery.find(set_delivery[:id]).name
    when "新しいお届け先"
    end
  end

  def create
     @order = Order.new(order_params)
     @cart_items = current_customer.cart_items
     @order.save!
     redirect_to root_path
  end



  def complete
  end

  private

   def order_params
     params.require(:order).permit(:pay, :postcode, :address, :name, :postage, :charge, :customer_id)
   end

   def set_delivery
    params.require(:order).require(:delivery).permit(:id)
  end

end
