class OrdersController < ApplicationController
  def index
    @orders = Order.where("user_id LIKE ?", current_user.id).order(created_at: :desc)

  end

  def show
    @order = Order.find(params[:id])
  end

end
