namespace :csp_reports do
  desc "Populate CSP Violations Report"
  task populate: :environment do
    user = User.first
    domain = user.domains.find_or_create_by(name: "My domain", url: "http://mydomain.com")

    10.times do
      domain.reports.create(
        result: {
          "referrer" => "",
          "blocked-uri" => "https://avatars1.githubusercontent.com",
          "status-code" => "200",
          "document-uri" => "http://mydomain.com/newsletters/15",
          "original-policy" => %(
            default-src 'none'; object-src 'self'; img-src 'self' *.srcclr.com https://ssl.google-analytics.com data:;
            report-uri http://open.domain.com/report-uri/28b7a142-2fb9-4184-a639-93229a31d148;
          ),
          "violated-directive" => "img-src 'self' *.srcclr.com https://ssl.google-analytics.com data:",
          "effective-directive" => "img-src"
        }
      )
    end
  end
end
