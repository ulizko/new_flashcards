module Home
  class UsersController < ApplicationController
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
      @user = User.new(user_params)
      if @user.save
        ahoy.track 'User registered', email: user_params[:email]
        auto_login(@user)
        redirect_to root_path, notice: t(:user_created_successfully_notice)
      else
        render 'new'
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
