require 'rubygems'
require 'rubygems/package_task'
require 'rake/contrib/sshpublisher'
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

PKG_NAME      = 'lipsiadmin'
PKG_VERSION   = Lipsiadmin::VERSION
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

gemspec = Gem::Specification.new do |spec|
  spec.platform      = Gem::Platform::RUBY
  spec.name          = PKG_NAME
  spec.version       = PKG_VERSION
  spec.authors       = ["Davide D'Agostino"]
  spec.email         = ["d.dagostino@lipsiasoft.com"]
  spec.summary       = "Lipsiadmin is a new revolutionary admin for your projects. Lipsiadmin is based on Ext Js 2.0. framework (with prototype adapter) and is ready for Rails 2.0. This admin is for newbie developper but also for experts, is not entirely written in javascript because the aim of developper wose build in a agile way web/site apps so we use extjs in a new intelligent way a mixin of 'old' html and new ajax functions, for example ext manage the layout of page, grids, tree and errors, but form are in html code."
  spec.homepage      = "http://www.lipsiadmin.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "haml", "~> 4.0"
  spec.add_development_dependency 'rails', '~> 4.2', '>= 4.2.5.1'
  spec.add_development_dependency 'bartt-ssl_requirement', '~>1.4.0'
end

# Gem::PackageTask.new(gemspec) do |pkg|
#   # pkg.gem_spec = gemspec
#   pkg.need_tar = true
#   pkg.need_zip = true
# end
