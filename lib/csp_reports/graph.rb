module CspReports
  class Graph
    attr_reader :reports

    def initialize(reports)
      @reports = reports
    end

    def draw
      graph = Gruff::Line.new
      graph.title = "CSP Violations Graph"
      graph.hide_legend = true

      if reports.any?
        reports.each_with_index do |h, index|
          graph.labels[index] = h.first
        end

        graph.dataxy(:violations, graph.labels.keys, reports.values, "#00afd7")
        graph.y_axis_increment = reports.values.max.fdiv(10).floor
        graph.minimum_value = 0
        graph.maximum_value = reports.values.max + 1
        graph.bottom_margin = 60
        graph.right_margin = 40
        graph.left_margin = 40
        graph.marker_font_size = 13
      end

      graph.write(filepath)
    end

    def url
      @url ||= "#{Discourse.base_url}/#{filename}"
    end

    private

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
