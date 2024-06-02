class CreateWatches < ActiveRecord::Migration[7.1]
  def change
    create_table :watches do |t|
      t.string :name, null: false
      t.string :description
      t.decimal :price, precision: 11, scale: 2, null: false
      t.string :image

      t.timestamps
    end
  end
end
