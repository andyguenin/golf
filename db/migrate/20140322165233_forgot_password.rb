class ForgotPassword < ActiveRecord::Migration
  def change 
	add_column :users, :forgot_password, :string
  end
end
