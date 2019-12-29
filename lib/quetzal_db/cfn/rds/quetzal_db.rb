# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module RDS
      module QuetzalDb
        class << self
          # @return [String]
          attr_accessor :resource_name

          # @return [Hash]
          attr_accessor :properties

          # @return [Proc]
          def generate
            proc do
              resource = ::QuetzalDb::Cfn::RDS::QuetzalDb

              Resource resource.resource_name do
                Type 'AWS::RDS::DBInstance'
                Property 'DBInstanceClass', FnFindInMap(:Stages, Ref(:Stage), :DBInstanceType)
                instance_eval(&resource.master_user_password)
                instance_eval(&resource.master_user_name)
                instance_eval(&resource.security_groups)

                resource.properties.each do |property, value|
                  Property property, value
                end
              end
            end
          end

          # @return [Proc]
          def master_user_password
            proc do
              Property 'MasterUserPassword', FnJoin('', [
                                                      '{{resolve:secretsmanager:',
                                                      Ref(:QuetzalDbRootSecret),
                                                      ':SecretString:password}}'
                                                    ])
            end
          end

          # @return [Proc]
          def master_user_name
            proc do
              Property 'MasterUsername', FnJoin('', [
                                                  '{{resolve:secretsmanager:',
                                                  Ref(:QuetzalDbRootSecret),
                                                  ':SecretString:username}}'
                                                ])
            end
          end

          # @return [Proc]
          def security_groups
            proc do
              Property 'VPCSecurityGroups', [
                FnGetAtt(::QuetzalDb::Cfn::Config[:TargetSecurityGroup][:resource_name], :GroupId)
              ]
            end
          end
        end
      end
    end
  end
end
