# frozen_string_literal: true

module HexletCode
  module Utils
    module_function

    def blank?(obj)
      obj.respond_to?(:empty?) ? !!obj.empty? : !obj
    end

    def present?(obj)
      !blank?(obj)
    end

    def presence(obj)
      obj if present?(obj)
    end
  end
end
