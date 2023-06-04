# frozen_string_literal: true

require_relative "hexlet_code/version"
require "pry"

# Main namespace
module HexletCode
  autoload :Tag, "hexlet_code/tag"
  autoload :Utils, "hexlet_code/utils"

  INPUT_NAMES = {
    text: "textarea"
  }.freeze

  TYPE_ATTRS = {
    input: "text"
  }

  DEFAULT_INPUT_OPTS = {
    textarea: { cols: "20", rows: "40" },
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

    type = options.delete(:as)
    tag_name = INPUT_NAMES[type] || "input"
    type_attr = TYPE_ATTRS[tag_name.to_sym]
    opts = Utils.presence(options) || Utils.presence(DEFAULT_INPUT_OPTS[tag_name.to_sym]) || {}

    attrs = { name: name.to_s }
    attrs = attrs.merge(type: type_attr) if !type_attr.nil?
    attrs = attrs.merge(value: value) if Tag::SINGLE_TAGS.include?(tag_name)
    attrs = attrs.merge(opts)

    add_form_input(Tag.build(tag_name, attrs) { value })
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
