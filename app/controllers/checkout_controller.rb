class CheckoutController < ApplicationController
    def create
        count = 0
        taxes = Province.find_by_id(current_user.province_id).total_tax
    
        order = []
        items = []
    
        receipt = Order.create(tax_rate: taxes, total: session[:total].to_d, user_id: current_user.id, 
                                      address: current_user.address, city_province: (current_user.city + " " + Province.find_by_id(current_user.province.id).name), 
                                      postal_code: current_user.postal_code)
    
        session[:shopping_cart].each do | item_id |
          game = Game.find_by_id(item_id)
          order[count] = GameOrder.create(game: game, order: receipt, product: game.name, price: game.price, quantity: session[:shopping_cart_quantity][count].to_i)
          session[:temp] = order[count].errors.full_messages
          count = count + 1
        end
    
        respond_to do |format|
          format.js
        end
    
        
        order.each do | item |
          items << {
          name: item.product,
          amount: (item.price * 100).to_i,
          currency: "cad",
          quantity: item.quantity
          }
        end

        items << {
            name: "Total Taxes",
            amount: (session[:taxes] * 100).to_i,
            currency: "cad",
            quantity: 1
            }
    
        @session = Stripe::Checkout::Session.create(
                #went to stripe API, looked up sessions, figured it all out..
                payment_method_types: ["card"],
                success_url:  checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
                cancel_url:   checkout_cancel_url,
                mode: "payment",
                line_items: items,
        )

        respond_to do |format|
            format.js
        end
    
        session[:shopping_cart] = []
        session[:shopping_cart_quantity] = []
        session[:total] = 0
        session[:taxes] = 0

        redirect_to orders_path
        
      end
    
      def success
    
      end
    
      def cancel
    
      end
    
end
