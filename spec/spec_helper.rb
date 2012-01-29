$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec'
require 'rspec/core'
require 'rspec/expectations'
require 'mongoid'

Mongoid.configure do |config|
  name = "mongoid-role-player-test"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
end

require 'active_support'
require 'role_player' # and any other gems you need



def user_class
  klass = Class.new do
    include Mongoid::Document
    include Mongoid::RolePlayer
    store_in :users 

    key :name,       String
  end

  klass.collection.remove
  klass
end


RSpec.configure do |config|
  # some (optional) config here
  config.include RSpec::Matchers
  # config.include Mongoid::Matchers
  config.mock_with :rspec
  config.after :all do
    Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
  end
end