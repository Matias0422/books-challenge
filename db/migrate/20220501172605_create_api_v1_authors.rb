class CreateApiV1Authors < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_authors do |t|
      t.string :name

      t.timestamps
    end
  end
end
