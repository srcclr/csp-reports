require "rails_helper"

module CspReports
  describe ReportSerializer do
    let(:report) { FactoryGirl.create(:report) }

    subject(:serializer) { described_class.new(report).as_json }

    it "provides report creation date" do
      expect(serializer["report"][:created_at]).to be_present
    end

    it "provides report results hash" do
      expect(serializer["report"][:result]).to be_kind_of(Hash)
    end

    it "provides report results with proper fields" do
      %w(document-uri referrer violated-directive original-policy blocked-uri).each do |attr|
        expect(serializer["report"][:result][attr]).to be_present
      end
    end
  end
end
