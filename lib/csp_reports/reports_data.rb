module CspReports
  class ReportsData
    def initialize(reports, type)
      @reports = reports
      @type = type
    end

    def data
      return data_hash if data_hash.size < 2

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
      DateTime.parse(data_hash.keys.first)
    end

    def reports_end
      DateTime.parse(data_hash.keys.last)
    end

    def group_expression
      "TO_CHAR(created_at, '#{group_expression_format}')"
    end

    def group_expression_format
      @type == "daily" ? "HH:00" : "YYYY-MM-DD"
    end
  end
end
