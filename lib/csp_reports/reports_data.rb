module CspReports
  class ReportsData
    def initialize(reports, type)
      @reports = reports
      @type = type
    end

    def data
      empty_hash.merge(data_hash)
    end

    private

    def data_hash
      @data_hash ||= @reports.group(group_expression).order(group_expression).count
    end

    def empty_hash
      Hash[empty_keys.zip(Array.new(empty_keys.size, 0))]
    end

    def empty_keys
      @empty_keys ||= reports_start.step(reports_end, step).map { |t| t.strftime(format) }
    end

    def step
      @type == "daily" ? (1.to_f / 24) : 1
    end

    def format
      @type == "daily" ? "%H:%M" : "%Y-%m-%d"
    end

    def reports_start
      dt = DateTime.parse(data_hash.keys.first)
      @type == "daily" ? dt.beginning_of_week : dt.beginning_of_month
    end

    def reports_end
      dt = DateTime.parse(data_hash.keys.last)
      @type == "daily" ? dt.end_of_week : dt.end_of_month
    end

    def group_expression
      "TO_CHAR(created_at, '#{group_expression_format}')"
    end

    def group_expression_format
      @type == "daily" ? "HH:00" : "YYYY-MM-DD"
    end
  end
end
