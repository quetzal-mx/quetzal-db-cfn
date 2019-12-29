# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module SecretsManager
      module TargetAttachment
        class << self
          # @return [String]
          attr_accessor :resource_name

          # @return [Array<Hash>]
          attr_accessor :properties

          # @return [Proc]
          def generate
            proc do
              resource = ::QuetzalDb::Cfn::SecretsManager::TargetAttachment
              Resource resource.resource_name do
                Type 'AWS::SecretsManager::SecretTargetAttachment'
                Property 'SecretId', Ref(::QuetzalDb::Cfn::SecretsManager::RootSecret.resource_name)
                Property 'TargetId', Ref(::QuetzalDb::Cfn::RDS::QuetzalDb.resource_name)
                Property 'TargetType', 'AWS::RDS::DBInstance'
              end
            end
          end
        end
      end
    end
  end
end
