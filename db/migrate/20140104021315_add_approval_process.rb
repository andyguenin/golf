class AddApprovalProcess < ActiveRecord::Migration
  def up
    add_column :pools, :require_approval, :boolean
    add_column :picks, :approved, :boolean
    add_column :picks, :approver, :integer
  end
end
