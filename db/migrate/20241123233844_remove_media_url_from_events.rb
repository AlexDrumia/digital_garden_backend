class RemoveMediaUrlFromEvents < ActiveRecord::Migration[7.2]
  def up
    remove_column :events, :media_url
  end

  def down
    add_column :events, :media_url, :string
  end
end
