class Admin::HomeController < ApplicationController
  before_action :authenticate_admin_admin!

  def top
    @orders = Order.where("created_at >= ?", Date.current)
  end

end
