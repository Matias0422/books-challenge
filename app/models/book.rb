class Book < ApplicationRecord
  belongs_to :author, optional: false

  has_and_belongs_to_many :users

  validates_presence_of :title, :description
end
