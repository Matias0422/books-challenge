class AddImageableToPicture < ActiveRecord::Migration[7.0]
  def change
    add_reference :pictures, :imageable, polymorphic: true, null: false
  end
end
