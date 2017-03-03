# -*- encoding: utf-8 -*-
# stub: gitlab 3.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "gitlab"
  s.version = "3.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nihad Abbasov"]
  s.bindir = "exe"
  s.date = "2016-08-16"
  s.description = "Ruby client and CLI for GitLab API"
  s.email = ["mail@narkoz.me"]
  s.executables = ["gitlab"]
  s.files = ["exe/gitlab"]
  s.homepage = "https://github.com/narkoz/gitlab"
  s.licenses = ["BSD"]
  s.rubygems_version = "2.4.8"
  s.summary = "A Ruby wrapper and CLI for the GitLab API"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["~> 0.13.0"])
      s.add_runtime_dependency(%q<terminal-table>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, ["~> 0.13.0"])
      s.add_dependency(%q<terminal-table>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, ["~> 0.13.0"])
    s.add_dependency(%q<terminal-table>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end
