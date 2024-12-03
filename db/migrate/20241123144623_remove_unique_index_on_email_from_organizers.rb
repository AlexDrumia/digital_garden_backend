class RemoveUniqueIndexOnEmailFromOrganizers < ActiveRecord::Migration[7.2]
  def change
    remove_index :organizers, :email
  end
end
