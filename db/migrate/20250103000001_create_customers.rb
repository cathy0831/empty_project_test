class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :account, null: false
      t.string :name
      t.string :password_digest
      t.bigint :permission_id
      t.text :note
      t.integer :state, default: 0

      t.timestamps
    end

    add_index :customers, :account, unique: true
    add_index :customers, :permission_id
    add_foreign_key :customers, :permissions
  end
end
