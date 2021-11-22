class ApplicationController < ActionController::Base
    before_action :initialize_session

    def initialize_session
        session[:shopping_cart] ||= []
        session[:shopping_cart_quantity] ||= []
    end

    def cart
        Game.find(session[:shopping_cart])
    end
end
