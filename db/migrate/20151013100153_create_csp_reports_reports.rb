class CreateCspReportsReports < ActiveRecord::Migration
  def change
    create_table :csp_reports_reports do |t|
      t.hstore :result, default: {}, null: false, using: :gin
      t.references :csp_reports_domain, index: true, foreign_key: true

      t.timestamps
    end
  end
end
