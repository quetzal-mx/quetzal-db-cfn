# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quetzal_db/cfn/version'

Gem::Specification.new do |spec|
  spec.name          = 'quetzal-db-cfn'
  spec.version       = QuetzalDb::Cfn::VERSION
  spec.authors       = ['Arnaldo Garcia']
  spec.email         = ['asgar.2792@gmail.com']

  spec.summary       = 'Quetzal DB cfn template'
  spec.description   = 'Quetzal DB cfn template'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'solargraph'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'cfndsl'
end
