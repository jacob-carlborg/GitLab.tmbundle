require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/uri-ssh_git-2.0.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/git_clone_url-2.0.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/multi_xml-0.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/httparty-0.14.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/unicode-display_width-1.1.3/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/terminal-table-1.7.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/bundler/gems/gitlab-9b24b85674b0/lib"
