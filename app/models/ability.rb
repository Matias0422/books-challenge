class Ability
  include CanCan::Ability

  def initialize(user)
    initialize_librarian if user.has_role? UserRole::LIBRARIAN.to_sym
  end

  private

  def initialize_librarian
    can :manage, Book
    can :manage, Author
  end
end
