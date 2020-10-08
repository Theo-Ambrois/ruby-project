class RemoveNameColumnUsers < ActiveRecord::Migration[6.0]
  remove_column :users, :firstname
  remove_column :users, :lastname
end
