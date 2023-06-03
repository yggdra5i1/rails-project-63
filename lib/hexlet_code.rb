# frozen_string_literal: true

require_relative "hexlet_code/version"

# Main namespace
module HexletCode
  autoload :Tag, "hexlet_code/tag"

  INPUT_ALIASES = {
    text: "textarea"
  }.freeze

  DEFAULT_INPUT_OPTS = {
    text: { cols: "20", rows: "40" },
    input: { type: "text" }
  }.freeze

  module_function

  def form_for(object, options = {}, &block)
    set_object(object)
    action = options[:url] || "#"
    method = options[:method] || "post"
    block.call(self) if block_given?

    Tag.build("form", action: action, method: method)
  end

  def input(name, options = {})
    value = object.public_send(name)
    return if value.nil?

    as = options.delete(:as)
    tag_name = INPUT_ALIASES[as] || "input"
    opts = options.any? ? options : DEFAULT_INPUT_OPTS[tag_name.to_sym]

    Tag.build(tag_name, *opts) { value }
  end

  def set_object(obj)
    @object = obj
  end

  def object
    @object
  end
end
