class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render "edit"
    end
  end

  def withdraw
  end


  def destroy
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name, :last_name_kana,:first_name_kana,:postcode,:address,:phone_number,:email)
  end

end
