require 'net/http'
require 'net/https'
require 'builder'
require 'multi_json'
require 'cgi'
require 'openssl'
require 'base64'
require 'jwt'

require 'twilio-ruby/version' unless defined?(Twilio::VERSION)
require 'twilio-ruby/util'
require 'twilio-ruby/util/request_validator'
require 'twilio-ruby/util/capability'
require 'twilio-ruby/twiml/response'
require 'twilio-ruby/rest/errors'
require 'twilio-ruby/rest/utils'
require 'twilio-ruby/rest/list_resource'
require 'twilio-ruby/rest/instance_resource'
require 'twilio-ruby/rest/sandbox'
require 'twilio-ruby/rest/accounts'
require 'twilio-ruby/rest/calls'
require 'twilio-ruby/rest/sms'
require 'twilio-ruby/rest/sms/messages'
require 'twilio-ruby/rest/sms/short_codes'
require 'twilio-ruby/rest/applications'
require 'twilio-ruby/rest/connect_apps'
require 'twilio-ruby/rest/authorized_connect_apps'
require 'twilio-ruby/rest/outgoing_caller_ids'
require 'twilio-ruby/rest/incoming_phone_numbers'
require 'twilio-ruby/rest/available_phone_numbers'
require 'twilio-ruby/rest/available_phone_numbers/country'
require 'twilio-ruby/rest/available_phone_numbers/local'
require 'twilio-ruby/rest/available_phone_numbers/toll_free'
require 'twilio-ruby/rest/conferences'
require 'twilio-ruby/rest/conferences/participants'
require 'twilio-ruby/rest/queues'
require 'twilio-ruby/rest/queues/members'
require 'twilio-ruby/rest/recordings'
require 'twilio-ruby/rest/transcriptions'
require 'twilio-ruby/rest/notifications'
require 'twilio-ruby/rest/client'
