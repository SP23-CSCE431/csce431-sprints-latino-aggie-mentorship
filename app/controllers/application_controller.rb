class ApplicationController < ActionController::Base
    before_action :authenticate_admin!

    # Set up CanCan to use 'current_admin' instead of 'current_user'
    def current_ability
        @current_ability ||= Ability.new(current_admin)
    end

    # rescue from AccessDenied error in CanCan
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, alert: exception.message
    end
end