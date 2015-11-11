class CreateSharedDomains < ActiveRecord::Migration
  def change
    create_table :csp_reports_viewers do |t|
      t.references :csp_reports_domains, index: true
      t.references :user, index: true
    end
  end
end
