# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module RDS
      extend ActiveSupport::Autoload
      extend Config::Configurable

      eager_autoload do
        autoload :QuetzalDb
      end

      eager_load!
      configure!
    end
  end
end
