class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login

  private

  def set_locale
    locale = if current_user
               current_user.locale
             elsif params[:user_locale]
               params[:user_locale]
             elsif session[:locale]
               session[:locale]
             else
               http_accept_language.compatible_language_from(I18n.available_locales)
             end

    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale
    else
      session[:locale] = I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def not_authenticated
    # Make sure that we reference the route from the main app.
    redirect_to main_app.login_path, alert: t(:please_log_in)
  end

  def permission_denied
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || main_app.root_path)
  end

  def not_found
    flash[:alert] = 'Вы обратились к несуществующей записи.'
    redirect_to root_path
  end
end
