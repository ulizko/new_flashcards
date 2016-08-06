module Dashboard
  class UsersController < BaseController

    def index
      @users = policy_scope(User).all
    end

    def destroy
      current_user.destroy
      redirect_to login_path, notice: 'Пользователь успешно удален.'
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :locale)
    end
  end
end
