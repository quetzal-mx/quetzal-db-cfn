# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module EC2
      module EIP
        class << self
          # @return [String]
          attr_accessor :resource_name

          # @return [String]
          attr_accessor :domain

          # @return [Proc]
          def generate
            resource = self
            proc do
              Resource resource.resource_name do
                Type 'AWS::EC2::EIP'
                Property 'Domain', resource.domain
              end
            end
          end
        end
      end
    end
  end
end
