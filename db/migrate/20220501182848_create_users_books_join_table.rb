class CreateUsersBooksJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :books

    add_index :books_users, [:user_id, :book_id], unique: true
  end
end
