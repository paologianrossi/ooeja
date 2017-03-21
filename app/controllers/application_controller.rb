class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: ->{ request.format.json? }

  def current_user
    @current_user ||= (session_user || token_user)
  end

  helper_method :current_user

  def authorize
    respond_to do |format|
      format.html { redirect_to login_path, notice: "Please login to continue" unless current_user }
      format.json { return invalid_authentication unless current_user }
    end
  end

  def invalid_authentication
    render json: {error: "Invalid Request"}, status: :unauthorized
  end

  private

  def session_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def token_user
    User.find(payload[0]['user_id']) if payload
  end

  def payload
    @payload ||= begin
                   auth_header = request.headers['Authorization']
                   token = auth_header.split(" ").last
                   JsonWebToken.decode(token)
                 rescue
                   nil
                 end
  end

end
