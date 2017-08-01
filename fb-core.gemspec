# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb/core/version'

Gem::Specification.new do |spec|
  spec.name          = 'fb-core'
  spec.version       = Fb::Core::VERSION
  spec.authors       = ['Claudio Baccigalupo']
  spec.email         = ['claudio@fullscreen.net']

  spec.summary       = %q{Ruby client to interact with Facebook Graph API.}
  spec.description   = %q{Fb::Core provides methods to interact with User and
    Pages through the Facebook Graph API.}
  spec.homepage      = 'https://github.com/Fullscreen/fb-core'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.4'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fb-support', '~> 1.0.0.alpha1'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9.9'
  spec.add_development_dependency 'coveralls'
end
