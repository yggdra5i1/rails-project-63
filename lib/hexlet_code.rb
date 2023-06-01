# frozen_string_literal: true

require_relative "hexlet_code/version"

# Main namespace
module HexletCode
  autoload :Tag, "hexlet_code/tag"

  extend self

  def form_for(object, &block)
    return nil
  end
end
