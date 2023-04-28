class SessionsController < ApplicationController

    def create
        @user = User.find_by(name: params[:name])

        if !!@user
            session[:user_id] = @user.name
            redirect_to search_path
        else
            message = "User does not exist"
            redirect_to login_path, notice: message
        end
    end

    def destroy
        message = "Logged out succesfully"
        redirect_to home_path, notice: message
    end
end