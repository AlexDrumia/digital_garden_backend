class AddAirtableIdToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :airtable_id, :string
    add_index :events, :airtable_id, unique: true
  end
end
