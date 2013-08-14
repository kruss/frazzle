# -*- encoding: utf-8 -*-
gem_name = 'frazzle'
require File.expand_path("lib/#{gem_name}/version")

spec = Gem::Specification.new do |s|
  s.name = gem_name
  s.version = Frazzle::VERSION

  s.description = 'plugin registry based on gems'
  s.author = "Kevin russ"
  s.email = "kevin.russ@esrlabs.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "gem plugin-manager using extention-points"
  s.files = `git ls-files`.split($\)
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
end
