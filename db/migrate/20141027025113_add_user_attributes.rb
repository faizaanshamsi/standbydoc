class AddUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :integer, null: false
    add_column :users, :name, :string, null: false
    add_index :users, :phone_number, unique: true
  end
end
