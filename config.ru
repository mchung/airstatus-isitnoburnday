ENV["TZ"] = "America/Phoenix"
ENV["RACK_ENV"] = "development" unless ENV["RACK_ENV"]

begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

if ENV["RACK_ENV"] == "production"
  log = File.new("log/#{ENV['RACK_ENV']}.log", "a")
  STDOUT.reopen(log)
  STDERR.reopen(log)
end

require File.dirname(__FILE__) + "/burn"
require File.dirname(__FILE__) + "/app"
run Burn::App
