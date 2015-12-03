class CreateEmailNotifications < ActiveRecord::Migration
  def change
    create_table :csp_reports_email_notifications do |t|
      t.references :user, index: true
      t.references :csp_reports_domain, index: true
      t.string :notification_type, default: "", null: false
    end
  end
end
