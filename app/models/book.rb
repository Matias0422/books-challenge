class Book < ApplicationRecord
  belongs_to :author, optional: false

  has_and_belongs_to_many :users_who_favorited, class_name: 'User',
                                                join_table: 'users_books',
                                                foreign_key: 'user_id',
                                                association_foreign_key: 'book_id'

  validates_presence_of :title, :description
end
