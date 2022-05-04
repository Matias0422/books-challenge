class Book < ApplicationRecord
  has_one :picture, as: :imageable, dependent: :destroy
  
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :users_who_favorited, class_name: 'User',
                                                join_table: 'books_users',
                                                foreign_key: 'user_id',
                                                association_foreign_key: 'book_id'

  validates_presence_of :title, :description

  scope :by_author_id, -> (author_id) { where(author_id: author_id) }
  scope :by_text_on_author_name, -> (text) { joins(:author).where("authors.name LIKE '%#{text}%'") }
  scope :by_text_on_name_or_description, -> (text) { where("title LIKE '%#{text}%' OR description LIKE '%#{text}%'") }
  scope :order_by_title, -> (order = 'ASC') { order("title #{order}") }

  accepts_nested_attributes_for :picture
  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :users_who_favorited, allow_destroy: true, update_only: true
end
