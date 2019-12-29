# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'

module QuetzalDb
  module Cfn
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Config, 'quetzal_db/cfn/config'
      autoload :Parameters, 'quetzal_db/cfn/parameters'
      autoload :SecretsManager, 'quetzal_db/cfn/secrets_manager'
      autoload :RDS, 'quetzal_db/cfn/rds'
      autoload :SecurityGroup, 'quetzal_db/cfn/security_group'
      autoload :SecurityGroupIngress, 'quetzal_db/cfn/security_group_ingress'
      autoload :SecurityGroupEgress, 'quetzal_db/cfn/security_group_egress'
      autoload :Mappings, 'quetzal_db/cfn/mappings'
      autoload :Outputs, 'quetzal_db/cfn/outputs'
      autoload :Create, 'quetzal_db/cfn/create'
      autoload :Update, 'quetzal_db/cfn/update'
    end

    class << self
      # @return [NilClass]
      def generate
        template_class = ::QuetzalDb::Cfn.const_get ENV['TEMPLATE_TYPE']
        template_class.generate
      end
    end

    eager_load!
  end
end

QuetzalDb::Cfn.generate
