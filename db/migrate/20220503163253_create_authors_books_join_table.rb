class CreateAuthorsBooksJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :authors, :books

    add_index :authors_books, [:author_id, :book_id], unique: true
  end
end
