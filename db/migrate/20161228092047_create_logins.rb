class CreateLogins < ActiveRecord::Migration[5.0]
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.string :user_type, limit: 10

      ## Database authenticatable
      t.string :login_token, null: false, default: ''
      t.string :login_secret, null: false, default: ''

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.timestamps
    end

    add_index :logins, [:user_id, :user_type], unique: true
  end
end
