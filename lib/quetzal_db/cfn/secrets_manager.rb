# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module SecretsManager
      extend ActiveSupport::Autoload
      extend Config::Configurable

      eager_autoload do
        autoload :RootSecret
        autoload :TargetAttachment
        autoload :Secret
      end

      eager_load!
      configure!
    end
  end
end
