class PetPolicy < ApplicationPolicy
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

  def edit?
    record.user == user || user.adoptions.where(pet_id: record.id).exists?
  end

  def update?
    record.user == user || user.adoptions.where(pet_id: record.id).exists?
  end

  def destroy?
    record.user == user
  end

  def adoption?
    user.adoptions.where(pet_id: record.id).exists?
  end

  def sell?
    Adoption.all.where(pet_id: record.id).last&.user == user && record.adopted == true
  end
end
