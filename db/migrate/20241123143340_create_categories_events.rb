class CreateCategoriesEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_events do |t|
      t.references :event, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :categories_events, [ :event_id, :category_id ], unique: true
    add_index :categories_events, [ :category_id, :event_id ], unique: true
  end
end
