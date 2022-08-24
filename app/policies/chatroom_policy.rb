class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where.not(adopted: true).adoption(created_at: :desc)
    end
  end

  def create?
    true
  end

  def show?
    true
  end
end
