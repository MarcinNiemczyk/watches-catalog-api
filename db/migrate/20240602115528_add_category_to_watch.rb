class AddCategoryToWatch < ActiveRecord::Migration[7.1]
  def change
    add_reference :watches, :category, null: true, foreign_key: true
  end
end
