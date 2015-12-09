module CspReports
  class Graph
    def initialize(reports, type)
      @reports = reports
      @type = type
    end

    def draw
      graph = Gruff::Line.new
      graph.title = "CSP Violations Graph"

      data_hash.each_with_index.map do |h, index|
        graph.labels[index] = "#{h.first.to_i}:00"
      end

      graph.dataxy(:violations, graph.labels.keys, data_hash.values, "#00afd7")
      graph.minimum_value = 0
      graph.maximum_value = data_hash.values.max + 1
      graph.hide_legend = true
      graph.write(filepath)
    end

    def url
      @url ||= "http://localhost:3000/#{filename}"
    end

    private

    def data_hash
      @data_hash ||= @reports.group("DATE_PART('hour', created_at)").count
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
