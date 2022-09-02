class PagePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where.not(adopted: true).adoption(created_at: :desc)
    end
  end

  def home?
    true
  end

  def about?
    true
  end

end
