# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "role_player/version"

Gem::Specification.new do |s|
  s.name        = "role_player"
  s.version     = RolePlayer::VERSION
  s.authors     = ["ph"]
  s.email       = ["patrick@heisiph.de"]
  s.homepage    = ""
  s.summary     = "A simple role-based authentication for RoR and mongoid"
  s.description = "A simple role-based authentication for RoR and mongoid"

  s.rubyforge_project = "role_player"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  
  s.add_development_dependency "rake"
  s.add_dependency "mongoid", ">= 2.3.4"
  s.add_dependency "activesupport"
  s.add_development_dependency "rspec"
  # s.add_development_dependency "bson_ext"
end
