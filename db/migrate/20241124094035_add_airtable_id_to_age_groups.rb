class AddAirtableIdToAgeGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :age_groups, :airtable_id, :string
  end
end
