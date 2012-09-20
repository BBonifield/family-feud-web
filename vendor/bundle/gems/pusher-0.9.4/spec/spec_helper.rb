begin
  require 'bundler/setup'
rescue LoadError
  puts 'although not required, it is recommended that you use bundler when running the tests'
end

require 'rspec'
require 'rspec/autorun'
require 'em-http' # As of webmock 1.4.0, em-http must be loaded first
require 'webmock/rspec'

require 'pusher'
require 'eventmachine'

def hmac(key, data)
  digest = OpenSSL::Digest::SHA256.new
  expected = OpenSSL::HMAC.hexdigest(digest, key, data)
end