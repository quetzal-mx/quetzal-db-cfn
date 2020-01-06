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
                resource_name = this.resource_name_from_conf(conf: value)

                Value send(value[:func], resource_name, value[:value])
                Export FnSub("${AWS::StackName}-#{output}")
              end
            end
          end
        end

        # @param conf [Hash]
        # @return [String]
        def resource_name_from_conf(conf:)
          return conf[:resource_class].constantize.resource_name if conf[:resource_class].present?

          ::QuetzalDb::Cfn::Config[conf[:config_name].to_sym][:resource_name]
        end
      end

      configure!
    end
  end
end
