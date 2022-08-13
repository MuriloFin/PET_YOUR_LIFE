class PagesController < ApplicationController
  def home
    if params[:query]
      @pets = Pet.global_search(params[:query])
    else
      # @pets = policy_scope(Pet)
      @pets = Pet.all
    end
  end
end
