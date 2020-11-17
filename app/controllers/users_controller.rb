class UsersController < ApplicationController
    # before_action :authenticate, only: :index
    def index
        @users = User.all
        render json: @users
    end

    def create
        secret_key = Rails.application.secrets.secret_key_base[0]
        @user = User.create(user_params)
        if @user.valid?
            @token = JWT.encode({user_id: @user.id, username: @user.username, admin: @user.admin}, secret_key)
            render json: {user: @user, token: @token}, status: :created
        else
            render json: {error: "Failed to create a user"}
        end 

    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :admin)
    end
end
