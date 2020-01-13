# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module EC2
      class Route
        # @return [String]
        attr_accessor :resource_name

        # @return [Hash]
        attr_accessor :target

        # @return [Hash]
        attr_accessor :destination

        # @return [String]
        attr_accessor :route_table

        # @param conf [Hash]
        def initialize(conf)
          conf.each do |key, value|
            send("#{key}=", value)
          end
        end

        # @return [Proc]
        def generate
          resource = self

          proc do
            Resource resource.resource_name do
              Type 'AWS::EC2::Route'
              Property 'RouteTableId', Ref(resource.route_table)
              Property resource.target[:target_type], Ref(resource.target[:target_value])
              Property resource.destination[:destination_type], resource.destination[:destination_value]
            end
          end
        end
      end
    end
  end
end
