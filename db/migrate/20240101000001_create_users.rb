class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :account
      t.string :password_digest
      t.string :name
      t.text :note
      t.integer :state, default: 0
      t.timestamps

      t.index :account, unique: true
    end
  end
end
