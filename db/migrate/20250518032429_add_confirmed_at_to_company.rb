class AddConfirmedAtToCompany < ActiveRecord::Migration[8.0]
  def up
    add_column :companies, :confirmation_token, :string
    add_column :companies, :confirmed_at, :datetime
    add_column :companies, :confirmation_sent_at, :datetime
    # add_column :companies, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :companies, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # companies as confirmed, do the following
    Company.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_index :companies, :confirmation_token
    remove_columns :companies, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :companies, :unconfirmed_email # Only if using reconfirmable
  end
end
