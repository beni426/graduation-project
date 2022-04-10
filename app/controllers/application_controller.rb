class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   before_action :configure_permitted_parameters, if: :devise_controller?
  #  around_action :set_locale
   def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guest@example.com' || email == 'guestadmin@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
  def set_locale
    I18n.locale = locale
  end

  def locale
    @locale ||= params[:locale] ||= I18n.default_locale
  end

  def default_url_options(options={})
    options.merge(locale: locale)
  end

    protected
  
    def configure_permitted_parameters
      if resource_class == User
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
          devise_parameter_sanitizer.permit(:sign_in,keys:[:email])
          devise_parameter_sanitizer.permit(:account_update,keys:[:name,:email])
      end
    end
   
end
