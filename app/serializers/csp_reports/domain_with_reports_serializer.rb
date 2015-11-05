module CspReports
  class DomainWithReportsSerializer < DomainSerializer
    has_many :reports

    private

    def reports
      options[:reports] || object.reports
    end
  end
end
