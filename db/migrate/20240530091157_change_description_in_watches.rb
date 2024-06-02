class ChangeDescriptionInWatches < ActiveRecord::Migration[7.1]
  def change
    change_column :watches, :description, :text, null: true
  end
end
