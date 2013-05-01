require 'rubygems'
require 'date'
require 'rubygems/package_task'
require 'rubygems/specification'
require 'rspec/core/rake_task'
 
GEM = 'open_apn'
GEM_NAME = 'open_apn'
GEM_VERSION = '0.5.0'
AUTHORS = ['Alex JHorovitz']
EMAIL = "alex@appliedintelligencehq.com"
HOMEPAGE = "https://github.com/AlexHorovitz/OpenAPN"
SUMMARY = "An open source Apple push notification gem"
 
spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["OPENSOURCE-LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(OPENSOURCE-LICENSE README.md Rakefile) + Dir.glob("{lib}/**/*")
end
 
task :default => :spec
 
desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--backtrace']
end
 

 
desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end
 
desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end