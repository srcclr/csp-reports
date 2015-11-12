module CspReports
  class DomainWithReportsSerializer < DomainSerializer
    has_many :reports
    has_many :viewers

    private

    def reports
      options[:reports] || object.reports
    end
  end
end
