require "rails_helper"

module CspReports
  describe "POST /report-uri/:report-uri-hash" do
    let!(:user) { FactoryGirl.create(:user, report_uri_hash: SecureRandom.uuid) }
    let!(:domain) { FactoryGirl.create(:domain, user: user, url:  "https://www.google.com/") }

    let(:referrer) { domain.url }

    let(:params) do
      {
        "csp-report" => {
          "document-uri" => "https://example.com/foo/bar",
          "referrer" => "https://www.google.com/",
          "violated-directive" => "default-src self",
          "original-policy" => "default-src self; report-uri /csp-hotline.php",
          "blocked-uri" => "http://evilhackerscripts.com"
        }
      }
    end

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:referrer).and_return(referrer)

      post "/csp-reports/report-uri/#{report_uri_hash}", params
    end

    context "when report-uri hash is valid" do
      let(:report_uri_hash) { user.report_uri_hash }

      context "when referrer domain is valid" do
        let(:created_report) { CspReports::Report.last }

        specify { expect(response.code).to eq("201") }
        specify { expect(created_report.result).to eq(params["csp-report"]) }
      end

      context "when referrer domain is invalid" do
        let(:referrer) { 'some malicious referrer' }

        specify { expect(response.code).to eq("401") }
      end
    end

    context "when report-uri-hash is invalid" do
      let(:report_uri_hash) { SecureRandom.uuid }

      specify { expect(response.code).to eq("404") }
    end
  end
end
