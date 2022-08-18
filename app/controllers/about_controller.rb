class AboutController < ApplicationController
  skip_before_action :skip_authorization
  def index; end
end
