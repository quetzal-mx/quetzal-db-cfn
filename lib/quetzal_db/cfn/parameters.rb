# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module Parameters
      extend Config::Configurable

      class << self
        # @return [Array<Hash>]
        attr_accessor :parameters

        # @return [Proc]
        def generate
          proc do
            ::QuetzalDb::Cfn::Parameters.parameters.each do |parameter, definition|
              Parameter parameter do
                Type definition[:type]
              end
            end
          end
        end
      end

      configure!
    end
  end
end
