class AddEventUrlToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :event_url, :string
  end
end
