class RemoveEventTypeFromEvents < ActiveRecord::Migration[7.2]
  def up
    remove_column :events, :event_type
  end

  def down
    add_column :events, :event_type, :string
  end
end
