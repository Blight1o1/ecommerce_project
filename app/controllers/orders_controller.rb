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
      order << Order.create(product: game.name, price: game.price, quantity: session[:shopping_cart_quantity][count].to_i, user_id: current_user.id)
      receipt << GameOrder.create(tax_rate: taxes.total_tax, total: session[:total].to_d, game: game, order: order)
      count = count + 1
    end

    respond_to do |format|
      format.js
    end

    @session = Stripe::Order::Session.create(
            #went to stripe API, looked up sessions, figured it all out..
            payment_method_types: ["card"],
            success_url:  checkout_success_url + "?session_id={ORDER_SESSION_ID}",
            cancel_url:   checkout_cancel_url,
            line_items: [
              order.each do | item |
                {
                name: item.product,
                amount: item.price,
                currency: "cad",
                quantity: item.quantity
                },
              end
                {
                name: "Total Taxes",
                amount: taxes,
                currency: "cad",
                quantity: 1
                }
            ]
        )

    session[:shopping_cart] = []
    session[:shopping_cart_quantity] = []
    session[:total] = 0
    session[:taxes] = 0

    redirect_to root_path
  end

  def success

  end

  def cancel

  end


end
