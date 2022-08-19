class PagesController < ApplicationController
  def home
  end

  def about
    skip_authorization
  end

  def terms
  end

  def touch
  end

  def donate
  end

end
