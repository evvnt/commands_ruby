# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'commands/version'

Gem::Specification.new do |spec|
  spec.name = 'commands'
  spec.version = Commands::VERSION
  spec.authors = ['Evvnt Dev Team']
  spec.email = ['dev@evvnt.com']

  spec.summary = 'Commands Ruby'
  spec.homepage = 'http://github.com/evvnt/commands_ruby'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'zeitwerk', '~> 2.1'
  spec.add_runtime_dependency 'activesupport', '>= 5.0'

  spec.add_development_dependency 'pry', '~>0.10'
  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rspec', '~> 3.0'
end