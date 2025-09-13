class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.references :permission, foreign_key: { to_table: :permissions }
      t.string :name
      t.string :account
      t.string :password_digest
      t.text :note
      t.string :session_token
      t.integer :state, default: 0

      t.timestamps
    end

    add_index :users, :account, unique: true
  end
end
