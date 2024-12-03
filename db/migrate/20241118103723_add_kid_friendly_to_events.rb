class AddKidFriendlyToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :kid_friendly, :boolean, default: false
  end
end
