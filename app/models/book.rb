class Book < ApplicationRecord
  belongs_to :author, optinal: false

  validates_presence_of :title, :description, :image_url
end
