module CspReports
  class DomainWithReportsSerializer < DomainSerializer
    attributes :own_domain

    has_many :reports
    has_many :viewers, each_serializer: ViewerSerializer
    has_many :candidate_viewers, each_serializer: ViewerSerializer

    private

    def own_domain
      object.user == options[:current_user]
    end

    def reports
      options[:reports] || object.reports
    end
  end
end
