class AddQuantitiesToMovies < ActiveRecord::Migration[6.0]
  def self.up
    add_column :movies, :quantity, :integer
  end

  def self.down
    remove_column :movies, :quantity
  end
end
