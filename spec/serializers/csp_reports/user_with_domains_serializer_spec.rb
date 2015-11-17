require "rails_helper"

module CspReports
  describe UserWithDomainsSerializer do
    let!(:user) { FactoryGirl.create(:user, report_uri_hash: SecureRandom.uuid) }
    let!(:domain) { FactoryGirl.create(:domain, user: user) }

    subject(:serializer) { described_class.new(user).as_json }

    before do
      allow_any_instance_of(described_class).to receive(:options).and_return(host: "example.com")
    end

    it "provides users report-uri link" do
      expect(serializer["user_with_domains"][:report_uri]).to eq "example.com/report-uri/#{user.report_uri_hash}"
    end

    it "provides users domains list" do
      expect(serializer["user_with_domains"][:domains]).to be_present
      expect(serializer["user_with_domains"][:domains].size).to eq(1)
    end
  end
end
