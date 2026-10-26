class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |table|
      table.string :email, null: false
      table.string :password_digest, null: false

      table.timestamps
    end

    add_index :users, :email, unique: true
  end
end