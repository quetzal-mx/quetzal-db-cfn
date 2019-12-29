# frozen_string_literal: true

require 'yaml'

module Helpers
  class Template
    def initialize(path)
      @template = YAML.load_file(path)
    end

    def [](key)
      @template[key]
    end
  end
end
