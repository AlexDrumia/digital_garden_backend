class AddAirtableIdToOrganizers < ActiveRecord::Migration[7.2]
  def change
    add_column :organizers, :airtable_id, :string
    add_index :organizers, :airtable_id, unique: true
  end
end
