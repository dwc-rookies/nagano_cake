class Customer::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    @deliveries = Delivery.all
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.save!
    redirect_to deliveries_path(@delivery)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def delivery_params
    params.require(:delivery).permit(:postcode, :name, :address)
  end

end
