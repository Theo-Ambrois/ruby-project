class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :duree
      t.boolean :borrowed

      t.timestamps
    end
  end
end
