class CreateCspReportsDomains < ActiveRecord::Migration
  def change
    create_table :csp_reports_domains do |t|
      t.string :name
      t.string :url
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
