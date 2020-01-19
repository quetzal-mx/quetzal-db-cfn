# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module SecretsManager
      class Secret
        # @param conf [Hash]
        def initialize(conf)
          conf.each do |key, value|
            send("#{key}=", value)
          end
        end

        # @return [String]
        attr_accessor :resource_name

        # @return [String]
        attr_accessor :username

        # @return [Hash]
        attr_accessor :secret_string

        # @return [String]
        attr_accessor :description

        # @return [Proc]
        def generate
          resource = self

          proc do
            Resource resource.resource_name do
              Type 'AWS::SecretsManager::Secret'
              Property :Description, resource.description
              Property :GenerateSecretString, instance_eval(&resource.generate_secret_string)
            end
          end
        end

        # @return [Proc]
        def generate_secret_string
          resource = self

          proc do
            resource.secret_string.deep_merge(
              SecretStringTemplate: FnJoin('', [
                                             '{"username": "',
                                             Ref(resource.username),
                                             '"}'
                                           ])
            )
          end
        end
      end
    end
  end
end
