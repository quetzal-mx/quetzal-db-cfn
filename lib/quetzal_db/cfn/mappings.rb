# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module Mappings
      extend Config::Configurable

      class << self
        # @return [Hash]
        attr_accessor :mappings

        # @return [Proc]
        def generate
          resource = self
          proc do
            resource.mappings.each do |mapping, map|
              Mapping(mapping, map)
            end
          end
        end
      end

      configure!
    end
  end
end
