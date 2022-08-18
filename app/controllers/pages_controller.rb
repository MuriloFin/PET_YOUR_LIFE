class PagesController < ApplicationController
  def home
  end

  def about
    skip_authorization
  end
end
