module CspReports
  class DomainWithReportsSerializer < DomainSerializer
    has_many :reports
    has_many :viewers, each_serializer: ViewerSerializer
    has_many :candidate_viewers, each_serializer: ViewerSerializer

    private

    def reports
      options[:reports] || object.reports
    end
  end
end
