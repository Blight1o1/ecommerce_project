class ShoppingCartController < ApplicationController

    def create
        logger.debug("Adding #{params[:id]} to cart.")
    end

    def destroy
        
    end
end
