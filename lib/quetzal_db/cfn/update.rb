# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module Update
      extend ::QuetzalDb::Cfn::Config::Configurable

      class << self
        require 'cfndsl'

        # @return [Array<String>]
        attr_accessor :resources

        # @return [NilClass]
        def generate
          CloudFormation do
            Description 'QuetzalDB cfn template'

            instance_eval(&::QuetzalDb::Cfn::Update.generate_resources)
          end
        end

        # @return [Proc]
        def generate_resources
          proc do
            ::QuetzalDb::Cfn::Update.resources.each do |resource_class|
              resource = if resource_class.is_a?(String)
                           resource_class.constantize
                         else
                           klass = resource_class[:class].constantize
                           klass.new(::QuetzalDb::Cfn::Config[resource_class[:config].to_sym])
                         end

              instance_eval(&resource.generate)
            end
          end
        end
      end

      configure!
    end
  end
end
