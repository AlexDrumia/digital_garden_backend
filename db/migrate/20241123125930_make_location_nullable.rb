class MakeLocationNullable < ActiveRecord::Migration[7.2]
  def change
    change_column :events, :location, :string, null: true
  end
end
