class Customer::DeliveriesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @delivery = Delivery.new
   
    @deliveries = current_customer.deliveries
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    @delivery.save
    redirect_to deliveries_path(@delivery.id)
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    @delivery.update(delivery_params)
    redirect_to deliveries_path(@delivery.id)
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to deliveries_path
  end

  private
  def delivery_params
    params.require(:delivery).permit(:postcode, :name, :address)
  end

end
