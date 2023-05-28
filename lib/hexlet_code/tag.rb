# frozen_string_literal: true

module HexletCode
  class Tag
    SINGLE_TAGS = %w[
      !doctype
      area
      base
      br
      col
      embed
      hr
      img
      input
      keygen
      link
      meta
      param
      source
      track
      wbr
    ].freeze

    class << self
      def build(name, options = {}, &block)
        attrs = options.map { |attr, value| "#{attr}=\"#{value}\"" }.join(" ")
        content = block.call if block_given?
        
        if SINGLE_TAGS.include?(name)
          build_single_tag(name, attrs)
        else
          build_paired_tag(name, content, attrs)
        end
      end

      private

      def build_paired_tag(name, content, attrs = {})
        return "<#{name}>#{content}</#{name}>" if attrs.empty?

        "<#{name} #{attrs}>#{content}</#{name}>"
      end

      def build_single_tag(name, attrs = {})
        return "<#{name}>" if attrs.empty?

        "<#{name} #{attrs}>"
      end
    end
  end
end
