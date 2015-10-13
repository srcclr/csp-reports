require "rails_helper"

module CspReports
  describe "POST /report-uri/:report-uri-hash" do
    let!(:user) { FactoryGirl.create(:user, report_uri_hash: report_uri_hash) }
    let!(:domain) { FactoryGirl.create(:domain, user: user, url: "https://www.google.com/") }

    let(:report_uri_hash) { SecureRandom.uuid }

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
      post "/csp-reports/report-uri/#{report_uri_hash}", params
    end

    it "should respond with created" do
      expect(response.code).to eq("201")
    end

    context "report" do
      subject { CspReports::Report.last }

      its(:result) { is_expected.to eq(params["csp-report"]) }
    end
  end
end
