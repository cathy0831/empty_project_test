class CreatePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :content
      t.text :note
      t.integer :state, default: 0

      t.timestamps

      t.index :name, unique: true
    end
  end
end
