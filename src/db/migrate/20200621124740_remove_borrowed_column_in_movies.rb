class RemoveBorrowedColumnInMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :borrowed
  end
end
