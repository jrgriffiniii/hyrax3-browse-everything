# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'solr_wrapper'
require 'fcrepo_wrapper'
require_relative 'config/application'

Rails.application.load_tasks

def load_config(service, environment, defaults)
  config_file = environment == 'test' ? "config/#{service}_wrapper_test.yml" : ".#{service}_wrapper"
  return { config: config_file } if File.exist?(config_file)
  defaults
end

def with_servers(environment)
  return yield if ENV["#{environment}_SERVER_STARTED"]

  ENV["#{environment}_SERVER_STARTED"] = 'true'

  solr_defaults = {
    port: 8983,
    verbose: true,
    managed: true,
    version: '7.7.3'
  }
  fcrepo_defaults = {
    enable_jms: false,
    fcrepo_home_dir: "tmp/fcrepo4-#{environment}-data",
    managed: true,
    port: 8984,
    verbose: true,
    version: '4.7.5'
  }
  solr_config = load_config(:solr, environment, solr_defaults)

  SolrWrapper.wrap(solr_config) do |solr|
    ENV["SOLR_#{environment.upcase}_PORT"] = solr.port.to_s

    solr_config_path = File.join('solr', 'conf')

    unless Dir.exist?(solr_config_path)
      $stderr.puts "Solr configuration not found at #{solr_config_path}. Using ActiveFedora defaults"
      solr_config_path = File.join(File.expand_path("../..", File.dirname(__FILE__)), 'lib', 'generators', 'active_fedora', 'config', 'solr', 'templates', 'solr', 'conf')
    end

    solr.with_collection(name: "hydra-#{environment}", dir: solr_config_path) do
      FcrepoWrapper.wrap(load_config(:fcrepo, environment, fcrepo_defaults)) do |fcrepo|
        ENV["FCREPO_#{environment.upcase}_PORT"] = fcrepo.port.to_s
        yield
      end
    end
  end

  ENV["#{environment}_SERVER_STARTED"] = 'false'
end

namespace :server do
  desc 'Run Fedora and Solr for development environment'
  task :development do
    with_servers 'development' do
      begin
        sleep
      rescue Interrupt
        puts "Shutting down..."
      end
    end
  end
end

require 'solr_wrapper/rake_task' unless Rails.env.production?
