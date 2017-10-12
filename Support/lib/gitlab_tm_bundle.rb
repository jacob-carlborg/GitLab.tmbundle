if ENV.key?('TM_BUNDLE_SUPPORT')
  ENV['BUNDLE_GEMFILE'] = ENV['TM_BUNDLE_SUPPORT'] + '/Gemfile'
end

lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'

if ENV.key?('TM_SUPPORT_PATH')
  require ENV['TM_SUPPORT_PATH'] + '/lib/tm/htmloutput'
end

require 'gitlab_build_output'

require 'gitlab_tm_bundle/core_ext/string'
require 'gitlab_tm_bundle/dispatcher'

require 'gitlab_tm_bundle/commands/base'
require 'gitlab_tm_bundle/commands/job_output_command'

module GitLabTmBundle
end
