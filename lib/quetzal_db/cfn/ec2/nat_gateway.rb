# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module EC2
      module NATGateway
        class << self
          # @return [String]
          attr_accessor :resource_name

          # @return [String]
          attr_accessor :subnet

          # @return [String]
          attr_accessor :elastic_ip

          # @return [Proc]
          def generate
            resource = self

            proc do
              Resource resource.resource_name do
                Type 'AWS::EC2::NatGateway'
                Property 'AllocationId', FnGetAtt(resource.elastic_ip, :AllocationId)
                Property 'SubnetId', Ref(resource.subnet)
              end
            end
          end
        end
      end
    end
  end
end
