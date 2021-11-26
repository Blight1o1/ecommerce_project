class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :initialize_session
    before_action :configure_permitted_parameters, if: :devise_controller?


    def initialize_session
        session[:shopping_cart] ||= []
        session[:shopping_cart_quantity] ||= []
    end

    def cart
        Game.find(session[:shopping_cart])
    end

    protected

    def configure_permitted_parameters
        attributes = [:name, :username, :address, :city, :postal_code, :province_id]
        devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
        devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end

end
