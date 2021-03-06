# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uri/ssh_git/version'

Gem::Specification.new do |spec|
  spec.name          = 'uri-ssh_git'
  spec.version       = URI::SshGit::VERSION
  spec.authors       = ['sanemat']
  spec.email         = ['o.gata.ken@gmail.com']

  spec.summary       = 'Parse and build ssh format url'
  spec.description   = 'Parse and build ssh format url.'
  spec.homepage      = 'https://github.com/packsaddle/ruby-uri-ssh_git'
  spec.license       = 'MIT'

  spec.files         = \
    `git ls-files -z`
    .split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }
    .reject do |f|
      [
        '.travis.yml',
        'circle.yml',
        '.tachikoma.yml'
      ].include?(f)
    end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'test-unit'
end
