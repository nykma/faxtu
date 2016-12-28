class ChangeLoginTokenToCaseInsensitive < ActiveRecord::Migration[5.0]
  def change
    enable_extension :citext
    change_column :logins, :login_token, :citext
    add_index :logins, :login_token, unique: true
  end
end
