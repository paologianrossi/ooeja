class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    respond_to do |format|
      if user && user.authenticate(params[:password])
        format.html {
          session[:user_id] = user.id
          redirect_to root_path, notice: "Welcome back, #{user.name}!"
        }
        format.json {
          auth_token = JsonWebToken.encode({user_id: user.id})
          render json: { auth_token: auth_token }, status: :ok
        }
      else
        format.html { render :new }
        format.json { render json: {error: 'Invalid username / password'}, status: :unauthorized }
      end
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
