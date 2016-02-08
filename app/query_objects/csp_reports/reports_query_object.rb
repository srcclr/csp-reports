module CspReports
  class ReportsQueryObject
    attr_reader :domain_id, :options
    private :domain_id, :options

    def initialize(domain_id, options = {})
      @domain_id = domain_id
      @options = options
    end

    def all
      @reports = Report.where(csp_reports_domain_id: domain_id)
      @reports = @reports.where(created_at: filter_range) unless options[:all]
      @reports = @reports.order(created_at: options[:sort].to_sym) if options[:sort]
      @reports
    end

    private

    def default_range
      Range.new(Time.zone.now - 1.day, Time.zone.now)
    end

    def filter_range
      range_given? ? Range.new(options[:from], options[:to]) : default_range
    end

    def range_given?
      [options[:from], options[:to]].all?
    end
  end
end
