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
            resource = self
            config = ::QuetzalDb::Cfn::Config
            proc do
              Resource resource.resource_name do
                Type 'AWS::SecretsManager::SecretTargetAttachment'
                Property 'SecretId', Ref(config[:RootSecret][:resource_name])
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
