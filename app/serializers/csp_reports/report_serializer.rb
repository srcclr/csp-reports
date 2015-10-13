module CspReports
  class ReportSerializer < ActiveModel::Serializer
    attributes :result, :created_at
  end
end
