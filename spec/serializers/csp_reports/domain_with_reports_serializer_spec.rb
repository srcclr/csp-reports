require "rails_helper"

module CspReports
  describe DomainWithReportsSerializer do
    let(:domain) { FactoryGirl.create(:domain, reports: [report]) }
    let(:report) { FactoryGirl.create(:report) }
    let(:serializer) { described_class.new(domain) }

    subject { serializer.as_json["domain_with_reports"][:reports] }

    before { allow(serializer).to receive(:options).and_return({}) }

    it "provides domains reports" do
      expect(subject).to be_present
      expect(subject.size).to eq(1)
    end
  end
end
