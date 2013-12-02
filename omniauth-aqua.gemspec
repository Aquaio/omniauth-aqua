# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-aqua/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-aqua"
  s.version     = OmniAuth::Aqua::VERSION
  s.authors     = ["Michael Carroll"]
  s.email       = ["michael@aqua.io"]
  s.homepage    = "https://github.com/aquaio/omniauth-aqua"
  s.summary     = %q{OmniAuth strategy for Aqua.io}
  s.description = %q{OmniAuth strategy for Aqua.io}
  s.license     = "MIT"

  s.rubyforge_project = "omniauth-aqua"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.1.1'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
end
