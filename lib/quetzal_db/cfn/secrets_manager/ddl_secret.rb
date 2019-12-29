# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module SecretsManager
      module DDLSecret
        class << self
          # @return [String]
          attr_accessor :resource_name

          # @return [Array<Hash>]
          attr_accessor :properties

          # @return [Proc]
          def generate
            resource = self

            proc do
              Resource resource.resource_name do
                Type 'AWS::SecretsManager::Secret'

                resource.properties.each do |property, value|
                  Property property, value
                end
              end
            end
          end
        end
      end
    end
  end
end
