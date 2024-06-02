class CategoryCantBeNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :watches, :category_id, false
  end
end
