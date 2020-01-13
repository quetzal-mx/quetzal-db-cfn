# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module EC2
      extend ActiveSupport::Autoload
      extend Config::Configurable

      eager_autoload do
        autoload :RouteTable
        autoload :RouteTableAssociation
        autoload :Route
        autoload :EIP
        autoload :NATGateway
      end

      eager_load!
      configure!
    end
  end
end
