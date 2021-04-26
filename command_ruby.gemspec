# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'commands/version'

Gem::Specification.new do |spec|
  spec.name = 'Commands'
  spec.version = Commands::VERSION
  spec.authors = []
  spec.email = [""]

  spec.summary = 'Commands Ruby'
  spec.homepage = 'http://github.com/rx/presenters'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'dry-validation', '~> 0.10.5'
  spec.add_runtime_dependency 'dry-configurable', '~> 0.7.0'

  spec.add_development_dependency 'pry', '~>0.10'
  spec.add_development_dependency 'bundler', '>= 1.13'
  spec.add_development_dependency 'rspec', '~> 3.0'
end