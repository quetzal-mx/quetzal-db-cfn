# frozen_string_literal: true

module QuetzalDb
  module Cfn
    class SecurityGroupIngress
      # @return [String]
      attr_accessor :resource_name

      # @return [Hash]
      attr_accessor :properties

      # @return [String]
      attr_accessor :target_group

      # @return [String]
      attr_accessor :source_group

      # @param conf [Hash]
      def initialize(conf)
        conf.each do |prop, value|
          send("#{prop}=", value)
        end
      end

      # @return [Proc]
      def generate
        resource = self
        config = Config

        proc do
          Resource resource.resource_name do
            Type 'AWS::EC2::SecurityGroupIngress'
            Property :SourceSecurityGroupId, FnGetAtt(config[resource.source_group.to_sym][:resource_name], :GroupId)
            Property :GroupId, FnGetAtt(config[resource.target_group.to_sym][:resource_name], :GroupId)
            resource.properties.each do |property, conf|
              Property property, conf
            end
          end
        end
      end
    end
  end
end
