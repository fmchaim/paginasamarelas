class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name_service
      t.string :description_service
      t.string :photos
      t.string :category
      t.integer :price

      t.timestamps
    end
  end
end
