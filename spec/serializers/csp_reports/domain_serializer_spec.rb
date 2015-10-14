require "rails_helper"

module CspReports
  describe DomainSerializer do
    let(:domain) { FactoryGirl.create(:domain) }

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
