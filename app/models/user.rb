class User < ApplicationRecord    
  rolify before_add: :validate_role_kind
  
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_and_belongs_to_many :favorite_books, class_name: 'Book',
                                           join_table: 'users_books',
                                           foreign_key: 'book_id',
                                           association_foreign_key: 'user_id'

  private

  def validate_role_kind(role)

  end
end
