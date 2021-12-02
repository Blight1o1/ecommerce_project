class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def create
    count = 0
    taxes = Province.find_by_id(current_user.province_id)

    session[:shopping_cart].each do | item_id |
      game = Game.find_by_id(item_id)
      order = Order.create(product: game.name, price: game.price, quantity: session[:shopping_cart_quantity][count].to_i, user_id: current_user.id)
      receipt = GameOrder.create(tax_rate: taxes.total_tax, total: session[:total].to_d, game: game, order: order)
      count = count + 1
    end

    session[:shopping_cart] = []
    session[:shopping_cart_quantity] = []
    session[:total] = 0
    session[:taxes] = 0

    redirect_to root_path
  end
end
