# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module EC2
      class RouteTable
        # @param conf [Hash]
        def initialize(conf)
          conf.each do |key, value|
            send("#{key}=", value)
          end
        end

        # @return [String]
        attr_accessor :resource_name

        # @return [Array<String>]
        attr_writer :tags

        # @return [Proc]
        def generate
          resource = self

          proc do
            Resource resource.resource_name do
              Type 'AWS::EC2::RouteTable'
              Property 'Tags', resource.tags
              Property 'VpcId', Ref('VpcId')
            end
          end
        end

        # @return [Array<Hash>]
        def tags
          @tags.map do |key, value|
            { Key: key, Value: value }
          end
        end
      end
    end
  end
end
