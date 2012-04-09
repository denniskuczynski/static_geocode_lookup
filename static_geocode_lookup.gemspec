# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "static_geocode_lookup/version"

Gem::Specification.new do |s|
  s.name        = "static_geocode_lookup"
  s.version     = StaticGeocodeLookup::VERSION
  s.authors     = ["Dennis Kuczynski"]
  s.email       = ["dennis.kuczynski@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple wrapper for an AWK Script to lookup US Geocodes from a static spreadsheet.}
  s.description = %q{Simple wrapper for an AWK Script to lookup US Geocodes from a static spreadsheet.}

  s.rubyforge_project = "static_geocode_lookup"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
