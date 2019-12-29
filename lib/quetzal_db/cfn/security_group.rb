# frozen_string_literal: true

module QuetzalDb
  module Cfn
    class SecurityGroup
      # @param conf [Hash]
      def initialize(conf)
        conf.each do |key, value|
          send("#{key}=", value)
        end
      end

      # @return [String]
      attr_accessor :resource_name

      # @return [Hash]
      attr_accessor :properties

      # @return [Proc]
      def generate
        resource = self
        proc do
          Resource resource.resource_name do
            Type 'AWS::EC2::SecurityGroup'

            resource.properties.each do |property, value|
              Property property, value
            end
          end
        end
      end
    end
  end
end
