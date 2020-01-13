# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module RDS
      class SubnetGroup
        # @param conf [Hash]
        def initialize(conf)
          conf.each do |key, value|
            send("#{key}=", value)
          end
        end

        # @return [Hash]
        attr_accessor :properties

        # @return [String]
        attr_accessor :resource_name

        # @return [Proc]
        def generate
          resource = self
          proc do
            Resource resource.resource_name do
              Type 'AWS::RDS::DBSubnetGroup'
              resource.properties.each do |property, value|
                Property property, value
              end

              Property 'SubnetIds', Ref('SubnetIds')
            end
          end
        end
      end
    end
  end
end
