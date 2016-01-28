# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ratsit/version'

Gem::Specification.new do |spec|
  spec.name          = "ratsit"
  spec.version       = Ratsit::VERSION
  spec.authors       = ["Stefan Nyman"]
  spec.email         = ["stefan@qoorp.com"]

  spec.summary       = "Perform Ratsit searches for persons and companies."
  spec.description   = "Can search using either the open api endpoints or by using an api key. Search methods: OpenPersonSearch, OpenCompanySearch, SearchCompanies, SearchPersons, SearchOnePerson."
  spec.homepage      = "http://github.com/qoorp/ratsit"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"

  spec.add_runtime_dependency "faraday", "~> 0.9.2"
  spec.add_runtime_dependency "savon", "~> 2.10.0"
end
