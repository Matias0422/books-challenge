class CreateUsersBooksJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :books do |t|
      t.index :user_id
      t.index :book_id
    end
  end
end
