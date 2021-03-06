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
      flash[:notice]="会員情報を変更しました。"
      redirect_to customer_path
    else
      flash.now[:error]="入力内容に誤りがあります。"
      render "edit"
    end
  end

  def withdraw
  end

  def change
    @customer = current_customer
    if @customer.update(is_deleated: true)
        sign_out current_customer
    end
    redirect_to root_path
  end


  def destroy
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name, :last_name_kana,:first_name_kana,:postcode,:address,:phone_number,:email,:is_deleated)
  end

end
