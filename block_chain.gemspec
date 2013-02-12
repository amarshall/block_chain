# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'block_chain/version'

Gem::Specification.new do |gem|
  gem.name          = 'block_chain'
  gem.version       = BlockChain::VERSION
  gem.authors       = ['Andrew Marshall']
  gem.email         = ['andrew@johnandrewmarshall.com']
  gem.description   = %q{Makes it easy to chain nested blocks together without creating a ton of nesting.}
  gem.summary       = %q{Makes it easy to chain nested blocks together without creating a ton of nesting.}
  gem.homepage      = 'http://johnandrewmarshall.com/projects/block_chain'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
