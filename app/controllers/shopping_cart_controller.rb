class ShoppingCartController < ApplicationController
    before_action :authenticate_user!

    def create

    end

    def add_to_cart
        logger.debug("Adding #{params[:id]} to cart.")

        id = params[:id].to_i

        if !(session[:shopping_cart].include?(id))
            session[:shopping_cart] << id
            session[:shopping_cart_quantity] << 1
        else
            count = 0
            session[:shopping_cart].each do | item_id |
                if item_id == id
                    session[:shopping_cart_quantity][count] = session[:shopping_cart_quantity][count] + session[:quantity]
                end
                count = count + 1
            end
        end


        total()

        #session[:shopping_cart] << id
        redirect_to games_path
    end

    def edit
        id = params[:id].to_i
        quantity = params[:quantity].to_i

        if (session[:shopping_cart].include?(id))
            count = 0
            session[:shopping_cart].each do | item_id |
                if item_id == id
                    session[:shopping_cart_quantity][count] = session[:shopping_cart_quantity][count] + quantity
                    if session[:shopping_cart_quantity][count] <= 0
                        session[:shopping_cart].delete(id)
                        session[:shopping_cart_quantity].delete_at(count)
                    end
                end
                count = count + 1
            end
        end

        total()

        redirect_to shopping_cart_index_path
    end

    def destroy
        id = params[:id].to_i

        count = 0
        session[:shopping_cart].each do | item_id |
            if item_id == id
                session[:shopping_cart_quantity].delete_at(count)
            end
            count = count + 1
        end

        session[:shopping_cart].delete(id)

        total()

        redirect_to shopping_cart_index_path
    end

    def total
        
        count = 0
        session[:total] = 0
        session[:shopping_cart].each do | item_id |
            product = Game.find_by_id(item_id)
            session[:total] = session[:total].to_d + (product.price * session[:shopping_cart_quantity][count].to_d)
            count = count + 1
        end

        session[:taxes] = (session[:total].to_d * Province.find_by_id(current_user.province_id).total_tax.to_d)
    end
end
