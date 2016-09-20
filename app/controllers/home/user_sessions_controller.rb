module Home
  class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    skip_after_action :track_action

    def new
      if current_user
        redirect_to root_path
      else
        @user = User.new
      end
    end

    def create
      if @user = login(params[:email], params[:password])
        ahoy.track 'User is logged'
        redirect_back_or_to root_path, notice: t(:log_in_is_successful_notice)
      else
        flash.now[:alert] = t(:not_logged_in_alert)
        render action: 'new'
      end
      ahoy.authenticate(@user)
    end
  end
end
