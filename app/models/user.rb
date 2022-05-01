class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_and_belongs_to_many :books

  has_many :favorite_books, through: :users_books, source: :book
end
