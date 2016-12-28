class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :gender, limit: 1

      t.timestamps
    end
  end
end
