module CspReports
  class DomainWithReportsSerializer < DomainSerializer
    has_many :reports
  end
end
