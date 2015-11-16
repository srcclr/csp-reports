class CreateSharedDomains < ActiveRecord::Migration
  def change
    create_table :csp_reports_shared_domains do |t|
      t.references :csp_reports_domain, index: true
      t.references :user, index: true
    end
  end
end
