class AuthenticationController < ApplicationController
    
    def login
        @user = User.find_by(username: params[:username])

        if @user

            if @user.authenticate(params[:password])
                payload = { user_id: @user.id }
                secret = Rails.application.secrets.secret_key_base
                token = JWT.encode(payload, secret)

                render json: {
                    token: token,
                    cats: @user.cats,
                    user_id: @user.id
                }
            else
                render json: {message: "nice try asshole!!!"}, status: :unauthorized
            end
        else
            render json: {message: "nice try asshole"}, status: :unauthorized
        end
    end

end