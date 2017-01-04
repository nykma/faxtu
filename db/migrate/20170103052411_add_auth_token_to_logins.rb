class AddAuthTokenToLogins < ActiveRecord::Migration[5.0]
  def change
    add_column :logins, :auth_token, :string, limit: 16
  end
end
