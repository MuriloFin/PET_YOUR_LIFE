class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user!, unless: :auth_request?
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  before_action :configure_permitted_parameters, if: :devise_controller?
=======
  # def auth_request?
  #   params[:controller].include?("devise_token_auth") &&
  #     ((controller_name == "sessions" && action_name == "create") ||
  #     (controller_name == "registrations" && action_name == "create"))
  # end
 9538e6d38b6d80c5b007872b2f7b938cc470f9d1

  private

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:photo, :first_name, :last_name, :cpf, :telephone, :address])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :first_name, :last_name, :cpf, :telephone, :address])
  end


  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
