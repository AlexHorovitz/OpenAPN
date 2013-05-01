# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{open_apn}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Horovitz"]
  s.autorequire = %q{apns}
  s.date = %q{2013-05-01}
  s.description = %q{An open source Apple push notification gem}
  s.email = %q{alex@appliedintelligencehq.com}
  s.extra_rdoc_files = ["OPENSOURCE-LICENSE"]
  s.files = ["OPENSOURCE-LICENSE", "README.md", "Rakefile", "lib/open_apn", "lib/open_apn/base.rb", "lib/open_apn/notify.rb", "lib/open_apn.rb"]
  s.homepage = %q{https://github.com/AlexHorovitz/OpenAPN}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{An open source Apple push notification gem}

  s.add_development_dependency 'rspec'

end
