module CspReports
  class DomainViewersSerializer < ActiveModel::Serializer
    has_many :viewers, serializer: ViewerSerializer
    has_many :candidate_viewers, serializer: ViewerSerializer
  end
end
