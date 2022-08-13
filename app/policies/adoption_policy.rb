class AdoptionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.includes(:pet).where(user_id: user.id, pets: { adopted: true })
    end
  end

  def create?
    true
  end
end
