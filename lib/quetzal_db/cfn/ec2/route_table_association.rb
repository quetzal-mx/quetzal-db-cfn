# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module EC2
      class RouteTableAssociation
        # @param conf [Hash]
        def initialize(conf)
          conf.each do |key, value|
            send("#{key}=", value)
          end
        end

        # @return [String]
        attr_accessor :resource_name

        # @return [String]
        attr_accessor :route_table

        # @return [String]
        attr_accessor :subnet

        # @return [Proc]
        def generate
          resource = self

          proc do
            Resource resource.resource_name do
              Type 'AWS::EC2::SubnetRouteTableAssociation'
              Property :RouteTableId, Ref(resource.route_table)
              Property :SubnetId, Ref(resource.subnet)
            end
          end
        end
      end
    end
  end
end
