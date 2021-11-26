class ShoppingCartController < ApplicationController
    before_action :authenticate_user!

    def create
        logger.debug("Adding #{params[:id]} to cart.")

        id = params[:id].to_i

        if !(session[:shopping_cart].include?(id))
            session[:shopping_cart] << id
            session[:shopping_cart_quantity] << 1
        else
            count = 0
            session[:shopping_cart].each do | item_id |
                if item_id == id
                    session[:shopping_cart_quantity][count] = session[:shopping_cart_quantity][count] + 1
                end
                count = count + 1
            end
        end




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
        redirect_to shopping_cart_index_path
    end
end
