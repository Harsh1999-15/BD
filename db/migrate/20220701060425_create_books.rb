class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :edition
      t.integer :price
      t.date :r_year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
