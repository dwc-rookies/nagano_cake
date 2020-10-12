class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @customers = Customer.page(params[:page]).per(5)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer=Customer.find(params[:id])
    if @customer.update(customer_params)
       flash[:notice]="successfully"
       redirect_to admin_customers_path
    else
      render:edit
    end
  end
  
  
    private
  def customer_params
    params.require(:customer).permit(:last_name,:first_name, :last_name_kana,:first_name_kana,:postcode,:address,:phone_number,:email,:is_deleated)
  end

end
