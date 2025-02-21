class AddUsernameToUsers < ActiveRecord::Migration[8.0]
  def change
    # Column already exists, so we comment it out to prevent an error.
    # add_column :users, :username, :string
  end
end
