require 'rdoc/task'
require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

desc 'Default: install the gem.'
task default: [:install]

desc 'Generate documentation for the lipsiadmin plugin.'
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Lipsiadmin'
  rdoc.options << '--line-numbers' << '--inline-source' << '--accessor' << 'cattr_accessor=object'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.template = 'resources/rdoc/horo'
  rdoc.rdoc_files.include('README.rdoc', 'CHANGELOG')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Clean up files.'
task :clean do |t|
  FileUtils.rm_rf "doc"
  FileUtils.rm_rf "tmp"
  FileUtils.rm_rf "pkg"
end

desc "Unistall the gem from local"
task uninstall: [:clean] do
  sh %{gem uninstall #{PKG_NAME}} rescue nil
end

desc "Generate a gemspec file for GitHub"
task :gemspec do
  File.open("#{PKG_NAME}.gemspec", 'w') do |f|
    f.write gemspec.to_ruby
  end
end

desc "Publish the API documentation"
task pdoc: [:rdoc] do
  Rake::SshDirPublisher.new("root@lipsiasoft.net", "/mnt/www/apps/lipsiasoft/doc", "doc").upload
end

desc "Publish the release files to RubyGems."
desc "Release the gem"
task release: :package do
  sh "gem push pkg/#{PKG_NAME}-#{PKG_VERSION}.gem"
end
