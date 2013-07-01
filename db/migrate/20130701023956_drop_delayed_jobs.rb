class DropDelayedJobs < ActiveRecord::Migration
  def change
    remove_index "delayed_jobs", :name => "delayed_jobs_priority"
    drop_table :delayed_jobs

  end
end
