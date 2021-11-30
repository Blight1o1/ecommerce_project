class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def create
    count = 0
    taxes = Province.find_by(:id current_user.province_id)
    receipt = GameOrder.create(:tax_rate taxes.total_tax, )

    session[:shopping_cart].each do | item_id |
      order = Game.find_by_id(item_id)
      cart_orders = Order.create(product: order.name, price: order.price, quantity: shopping_cart_quantity[count])
      count = count + 1
    end


  end
end
