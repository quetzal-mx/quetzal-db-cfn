# frozen_string_literal: true

module QuetzalDb
  module Cfn
    module Create
      class << self
        require 'cfndsl'

        # @return [NilClass]
        def generate
          CloudFormation do
            Description 'QuetzalDB cfn template'
            Condition(:NotCreate, FnEquals('true', 'false'))
            Resource 'EmptyResource' do
              Type 'Custom::EmptyResource'
              Condition :NotCreate
            end
          end
        end
      end
    end
  end
end
