if ENV.key?('TM_BUNDLE_SUPPORT')
  ENV['BUNDLE_GEMFILE'] = ENV['TM_BUNDLE_SUPPORT'] + '/Gemfile'
end

lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module Bundler
  class RubygemsIntegration
    # The reason this technique is used to override the `config_map` method is
    # because if we define the `config_map` map method before `bundler/setup` is
    # required, Bundler will override our version of the method and used the
    # original one. If we try to override the `config_map` method after
    # `bundler/setup` is required it will be too late and Bundler has already
    # raised an error due to it not being able to find the gems.
    def self.method_added(name)
      return unless name == :config_map
      return if @config_map_defined # Avoid infinite recursion

      @config_map_defined = true

      # Override the `config_map` method that will be later defined by Bundler.
      # We do that to be able to make a copy of the `Gem::ConfigMap` constant
      # which contains the Ruby ABI version. Then we change the ABI version to
      # always be the same regardless of which version of Ruby is running this
      # TextMate bundle. We make the copy to make sure only Bundler sees this
      # change of the Ruby ABI version.
      define_method :config_map do
        @config_map ||= Gem::ConfigMap.dup.tap { |o| o[:ruby_version] = '2' }
      end
    end
  end
end

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
