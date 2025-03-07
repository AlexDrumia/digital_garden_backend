class CreateOrganizers < ActiveRecord::Migration[7.2]
  def change
    create_table :organizers do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.index :email, unique: true

      t.timestamps
    end
  end
end
