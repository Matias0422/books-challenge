class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Book if user.has_role? UserRole::LIBRARIAN
  end
end
