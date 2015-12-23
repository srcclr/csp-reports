class Gruff::Line
  def draw_label(x_offset, index)
    return if @hide_line_markers

    if !@labels[index].nil? && @labels_seen[index].nil?
      y_offset = @graph_bottom + LABEL_MARGIN

      # TESTME
      # FIXME: Consider chart types other than bar
      # TODO: See if index.odd? is the best stragegy
      y_offset += @label_stagger_height if index.odd?

      label_text = @labels[index]

      # TESTME
      # FIXME: Consider chart types other than bar
      if label_text.size > @label_max_size
        if @label_truncation_style == :trailing_dots
          if @label_max_size > 3
            # 4 because '...' takes up 3 chars
            label_text = "#{label_text[0 .. (@label_max_size - 4)]}..."
          end
        else # @label_truncation_style is :absolute (default)
          label_text = label_text[0 .. (@label_max_size - 1)]
        end

      end

      if x_offset >= @graph_left && x_offset <= @graph_right
        @d.fill = @font_color
        @d.font = @font if @font
        @d.stroke('transparent')
        @d.rotation = 45 # patch
        @d.text_align( LeftAlign ) # patch
        @d.font_weight = NormalWeight
        @d.pointsize = scale_fontsize(@marker_font_size)
        @d.gravity = NorthWestGravity
        @d = @d.annotate_scaled(@base_image,
                                1.0, 1.0,
                                x_offset, y_offset,
                                label_text, @scale)
        @d.rotation = -45
      end
      @labels_seen[index] = 1
      debug { @d.line 0.0, y_offset, @raw_columns, y_offset }
    end
  end
end
