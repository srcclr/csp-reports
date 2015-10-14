require "rails_helper"

module CspReports
  describe DomainWithReportsSerializer do
    let(:domain) { FactoryGirl.create(:domain, reports: [report]) }
    let(:report) { FactoryGirl.create(:report) }

    subject(:serializer) { described_class.new(domain).as_json }

    it "provides domains reports" do
      expect(serializer["domain_with_reports"][:reports]).to be_present
      expect(serializer["domain_with_reports"][:reports].size).to eq(1)
    end
  end
end
