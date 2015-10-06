User.class_eval do
  def generate_report_uri_hash
    update(report_uri_hash: Digest::SHA256.hexdigest(username))
  end
end
