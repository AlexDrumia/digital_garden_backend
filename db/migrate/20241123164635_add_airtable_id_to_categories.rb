class AddAirtableIdToCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :airtable_id, :string
    add_index :categories, :airtable_id, unique: true
  end
end
