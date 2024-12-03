class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :event_type, null: false
      t.string :location, null: false
      t.text :description
      t.datetime :start_datetime, null: false
      # Leaving end_datetime optional for open ended events
      t.datetime :end_datetime
      t.decimal :price, precision: 10, scale: 2
      t.string :media_url

      t.references :organizer, null: false, foreign_key: true

      t.timestamps

      t.index :name
      t.index :event_type
      t.index :start_datetime
      t.index :price
    end
  end
end
