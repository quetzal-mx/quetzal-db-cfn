# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module Outputs
      extend Config::Configurable

      class << self
        # @return [Hash]
        attr_accessor :outputs

        # @return [Proc]
        def generate
          this = self

          proc do
            this.outputs.each do |output, conf|
              Output(output) do
                Description conf[:description]
                value = conf[:value]
                resource_class = value[:resource_class].constantize

                Value send(value[:func], resource_class.resource_name, value[:value])
                Export FnSub("${AWS::StackName}-#{output}")
              end
            end
          end
        end
      end

      configure!
    end
  end
end
