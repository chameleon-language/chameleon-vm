# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chameleon/vm'

Gem::Specification.new do |spec|
  spec.name          = 'chameleon-vm'
  spec.version       = Chameleon::VM::VERSION
  spec.authors       = ['zs']
  spec.email         = ['baloghzsof@gmail.com']
  spec.summary       = 'chameleon vm'
  spec.description   = 'virtual machine for the chameleon language'
  spec.homepage      = 'https://github.com/chameleon-language/chameleon-vm'
  spec.license       = 'GPLv3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'nyan-cat-formatter'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov-gem-profile'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
