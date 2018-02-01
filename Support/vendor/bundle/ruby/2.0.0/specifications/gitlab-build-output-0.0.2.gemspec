# -*- encoding: utf-8 -*-
# stub: gitlab-build-output 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "gitlab-build-output"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib"]
  s.authors = ["Jacob Carlborg"]
  s.bindir = "exe"
  s.date = "2018-02-01"
  s.description = "Prints the output of a GitLab CI job."
  s.email = ["doob@me.com"]
  s.executables = ["gitlab-build-output"]
  s.files = ["exe/gitlab-build-output"]
  s.homepage = "https://github.com/jacob-carlborg/gitlab-build-output"
  s.rubygems_version = "2.4.8"
  s.summary = "Prints the output of a GitLab CI job."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<git>, ["~> 1.3"])
      s.add_runtime_dependency(%q<gitlab>, ["~> 4.0"])
      s.add_runtime_dependency(%q<git_clone_url>, ["~> 2.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.14"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>, ["= 0.48.1"])
      s.add_development_dependency(%q<pry>, ["~> 0.11"])
      s.add_development_dependency(%q<pry-rescue>, ["~> 1.4"])
      s.add_development_dependency(%q<pry-stack_explorer>, ["~> 0.4.9"])
    else
      s.add_dependency(%q<git>, ["~> 1.3"])
      s.add_dependency(%q<gitlab>, ["~> 4.0"])
      s.add_dependency(%q<git_clone_url>, ["~> 2.0"])
      s.add_dependency(%q<bundler>, ["~> 1.14"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rubocop>, ["= 0.48.1"])
      s.add_dependency(%q<pry>, ["~> 0.11"])
      s.add_dependency(%q<pry-rescue>, ["~> 1.4"])
      s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4.9"])
    end
  else
    s.add_dependency(%q<git>, ["~> 1.3"])
    s.add_dependency(%q<gitlab>, ["~> 4.0"])
    s.add_dependency(%q<git_clone_url>, ["~> 2.0"])
    s.add_dependency(%q<bundler>, ["~> 1.14"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rubocop>, ["= 0.48.1"])
    s.add_dependency(%q<pry>, ["~> 0.11"])
    s.add_dependency(%q<pry-rescue>, ["~> 1.4"])
    s.add_dependency(%q<pry-stack_explorer>, ["~> 0.4.9"])
  end
end
