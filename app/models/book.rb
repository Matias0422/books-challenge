class Book < ApplicationRecord
  belongs_to :author, optional: false

  validates_presence_of :title, :description
end
