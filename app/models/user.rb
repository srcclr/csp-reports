User.class_eval do
  has_many :domains, class_name: "CspReports::Domain"
  has_many :shared_domains, class_name: "CspReports::SharedDomain"
  has_many :friend_domains, through: :shared_domains, source: :domain, class_name: "CspReports::Domain"
  has_many :email_notifications, class_name: "CspReports::EmailNotification"

  def generate_report_uri_hash
    update(report_uri_hash: SecureRandom.uuid)
  end
end
