# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'cfndsl/rake_task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: :deploy

task test: ['test:spec', 'rubocop']

task deploy: ['template:compile', 'template:zip', 'template:upload']

namespace :template do
  task compile: ['template:compile:create', 'template:compile:update']

  task :zip do
    sh 'zip quetzal-db-cfn.zip quetzal-db-create-stack.yml quetzal-db-update-stack.yml'
  end

  task :upload do
    # TODO: integrar con cloudformation
    sh 'aws s3 cp quetzal-db-cfn.zip s3://quetzaldbpipeline-quetzaldbdeploymentsbucket-166eqau2wcegd/quetzal-db-cfn.zip'
  end

  namespace :compile do
    task create: ['template:compile:create:setup', 'template:compile:create:generate']
    task update: ['template:compile:update:setup', 'template:compile:update:generate']

    namespace :create do
      task :setup do
        ENV['TEMPLATE_TYPE'] = 'Create'
      end

      CfnDsl::RakeTask.new(:generate) do |t|
        t.cfndsl_opts = {
          files: [{
            filename: "#{File.dirname(__FILE__)}/lib/quetzal_db/cfn.rb",
            output: 'quetzal-db-create-stack.yml'
          }],
          outformat: 'yaml'
        }
      end
    end

    namespace :update do
      task :setup do
        ENV['TEMPLATE_TYPE'] = 'Update'
      end

      CfnDsl::RakeTask.new(:generate) do |t|
        t.cfndsl_opts = {
          files: [{
            filename: "#{File.dirname(__FILE__)}/lib/quetzal_db/cfn.rb",
            output: 'quetzal-db-update-stack.yml'
          }],
          outformat: 'yaml'
        }
      end
    end
  end
end

RuboCop::RakeTask.new

namespace :test do
  RSpec::Core::RakeTask.new(:spec, [] => ['template:compile'])
end
