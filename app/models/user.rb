User.class_eval do
  has_many :domains, class_name: "CspReports::Domain"
  has_many :shared_domains, class_name: "CspReports::Domain"

  def generate_report_uri_hash
    update(report_uri_hash: SecureRandom.uuid)
  end
end
