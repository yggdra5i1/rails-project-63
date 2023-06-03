# frozen_string_literal: true

require_relative "hexlet_code/version"

# Main namespace
module HexletCode
  autoload :Tag, "hexlet_code/tag"

  INPUT_ALIASES = {
    text: "textarea"
  }.freeze

  DEFAULT_INPUT_OPTS = {
    textarea: { cols: "20", rows: "40" },
    input: { type: "text" }
  }.freeze

  module_function

  def form_for(object, options = {}, &block)
    init_form_object(object)
    init_form_inputs
    action = options[:url] || "#"
    method = options[:method] || "post"
    block.call(self) if block_given?

    Tag.build("form", action: action, method: method) { form_inputs.join }
  end

  def input(name, options = {})
    value = form_object.public_send(name)
    return if value.nil?

    as = options.delete(:as)
    tag_name = INPUT_ALIASES[as] || "input"
    opts = (options.any? ? options : DEFAULT_INPUT_OPTS[tag_name.to_sym])
    opts = { name: name.to_s }.merge(opts)
    opts = opts.merge(value: value) if Tag::SINGLE_TAGS.include?(tag_name)
    add_form_input(Tag.build(tag_name, opts) { value })
  end

  def init_form_object(obj)
    @form_object = obj
  end

  def form_object
    @form_object
  end

  def init_form_inputs
    @form_inputs = []
  end

  def add_form_input(input)
    @form_inputs << input
  end

  def form_inputs
    @form_inputs
  end
end
