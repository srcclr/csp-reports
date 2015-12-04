require "rails_helper"

module CspReports
  describe DomainWithReportsSerializer do
    let(:domain) { FactoryGirl.create(:domain, reports: [report]) }
    let(:report) { FactoryGirl.create(:report) }
    let(:user) { FactoryGirl.create(:user) }
    let(:controller) { double(:controller, current_user: user) }
    let(:serializer) { described_class.new(domain) }

    subject { serializer.as_json["domain_with_reports"][:reports] }

    before do
      allow_any_instance_of(described_class).to receive(:scope).and_return(controller)
      allow(serializer).to receive(:options).and_return({})
    end

    it "provides domains reports" do
      expect(subject).to be_present
      expect(subject.size).to eq(1)
    end
  end
end
