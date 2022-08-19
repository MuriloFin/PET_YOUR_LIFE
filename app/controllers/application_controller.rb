class ApplicationController < ActionController::Base
  include Pundit
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user!, unless: :auth_request?
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # def auth_request?
  #   params[:controller].include?("devise_token_auth") &&
  #     ((controller_name == "sessions" && action_name == "create") ||
  #     (controller_name == "registrations" && action_name == "create"))
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
