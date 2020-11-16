class AuthenticationsController < ApplicationController
    def login
      user = User.find_by(username: params[:username])
      if(!user)
        render json: {error: "Invalid User"}, status: :unauthorized
    else
        if(user.authenticate(params[:password]))
            secret_key = Rails.application.secrets.secret_key_base[0]
            token = JWT.encode({
                user_id: user.id,
                username: user.username,
                admin: user.admin
            }, secret_key)
            render json: {token: token}
        else
            render json: {error: "Invalid Password"}, status: :unauthorized
        end
    end
  end
  
  
  
  end