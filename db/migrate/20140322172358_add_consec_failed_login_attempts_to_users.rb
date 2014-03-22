class AddConsecFailedLoginAttemptsToUsers < ActiveRecord::Migration
  def change
	add_column :users, :consec_failed_login_attempts, :integer
	add_column :users, :locked, :boolean
  end
end
