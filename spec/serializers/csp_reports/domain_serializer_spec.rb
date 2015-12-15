require "rails_helper"

module CspReports
  describe DomainSerializer do
    let(:domain) { FactoryGirl.create(:domain, user: user) }
    let(:user) { FactoryGirl.create(:user) }
    let(:controller) { double(:controller, current_user: user) }

    before do
      allow_any_instance_of(described_class).to receive(:scope).and_return(controller)
    end

    subject(:serializer) { described_class.new(domain).as_json }

    it "provides domain id" do
      expect(serializer["domain"][:id]).to be_present
    end

    it "provides domain name" do
      expect(serializer["domain"][:name]).to eq domain.name
    end

    it "provides domain url" do
      expect(serializer["domain"][:url]).to eq domain.url
    end
  end
end
