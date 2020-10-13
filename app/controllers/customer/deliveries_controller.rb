class Customer::DeliveriesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @delivery = Delivery.new
   
    @deliveries = current_customer.deliveries
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      flash[:notice]="配送先を追加しました。"
      redirect_to deliveries_path(@delivery.id)
    else
      flash.now[:error]="入力内容に誤りがあります。"
      render 'index'
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice]="配送先を編集しました。"
      redirect_to deliveries_path(@delivery.id)
    else
      flash.now[:error]="入力内容に誤りがあります。"
      render 'edit'
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    flash[:notice]="配送先を削除しました。"
    redirect_to deliveries_path
  end

  private
  def delivery_params
    params.require(:delivery).permit(:postcode, :name, :address)
  end

end
