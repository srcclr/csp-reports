class AddReportUriHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :report_uri_hash, :string

    add_index :users, :report_uri_hash
  end
end
