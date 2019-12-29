# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module SecretsManager
      extend ActiveSupport::Autoload
      extend Config::Configurable

      eager_autoload do
        autoload :RootSecret
        autoload :DDLSecret
        autoload :DMLSecret
        autoload :TargetAttachment
      end

      eager_load!
      configure!
    end
  end
end
