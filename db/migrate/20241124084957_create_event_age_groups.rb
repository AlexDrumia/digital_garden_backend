class CreateEventAgeGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :event_age_groups do |t|
      t.references :event, null: false, foreign_key: true
      t.references :age_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
