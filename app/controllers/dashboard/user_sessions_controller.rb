module Dashboard
  class UserSessionsController < ApplicationController
    def destroy
      logout
      redirect_to login_path, notice: t(:log_out_is_successful_notice)
    end
  end
end
