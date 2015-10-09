require 'rails_helper'

module CspReports
  describe DomainSerializer do
    describe "#as_json" do
      let(:domain) { build :domain }
      let(:serialized_query) { { id: 1, name: "Google", url: "google.com" } }

      subject(:serializer) { described_class.new(domain).as_json }

      it "serializes domain" do
        [:id, :name, :url].each do |attr|
          expect(serializer[attr]).to be_present
        end
      end
    end
  end
end
