module CspReports
  class Graph
    def initialize(reports, type)
      @reports = reports
      @type = type
    end

    def draw
      graph = Gruff::Line.new
      graph.title = "CSP Violations Graph"
      graph.hide_legend = true

      if @reports.any?
        data_hash.each_with_index.map do |h, index|
          graph.labels[index] = h.first
        end

        graph.dataxy(:violations, graph.labels.keys, data_hash.values, "#00afd7")
        graph.minimum_value = 0
        graph.maximum_value = data_hash.values.max + 1
      end

      graph.write(filepath)
    end

    def url
      @url ||= "#{Discourse.base_url}/#{filename}"
    end

    private

    def data_hash
      @data_hash ||= @reports.group(group_expression).order(group_expression).count
    end

    def group_expression
      if @type == "daily"
        "TO_CHAR(created_at, 'HH:00')"
      else
        "TO_CHAR(created_at, 'YYYY-MM-DD')"
      end
    end

    def filename
      @filename ||= "images/csp_reports/#{SecureRandom.uuid}.png"
    end

    def filepath
      if @filepath.blank?
        @filepath = "#{Rails.root}/public/#{filename}"
        FileUtils.mkdir_p(File.dirname(@filepath))
      end

      @filepath
    end
  end
end
