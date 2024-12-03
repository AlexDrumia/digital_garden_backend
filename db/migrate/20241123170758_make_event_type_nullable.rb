class MakeEventTypeNullable < ActiveRecord::Migration[7.2]
  def change
    change_column :events, :event_type, :string, null: true
  end
end
