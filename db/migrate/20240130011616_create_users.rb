class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :city
      t.string :state
      t.integer :phone

      t.timestamps
    end
  end
end
