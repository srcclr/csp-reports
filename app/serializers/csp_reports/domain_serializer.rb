module CspReports
  class DomainSerializer < ActiveModel::Serializer
    attributes :id, :name, :url
  end
end
