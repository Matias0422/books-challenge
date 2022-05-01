class CreateApiV1Books < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_books do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
