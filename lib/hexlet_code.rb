# frozen_string_literal: true

require_relative "hexlet_code/version"

# Main namespace
module HexletCode
  autoload :Tag, "hexlet_code/tag"

  module_function

  def form_for(_object, options = {})
    action = options[:url] || "#"
    Tag.build("form", action: action, method: "post")
  end
end
