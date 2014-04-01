class AddLastRunToScrapers < ActiveRecord::Migration
  def change
    add_column :scrapers, :last_run, :datetime
    add_column :scrapers, :running, :boolean
  end
end
