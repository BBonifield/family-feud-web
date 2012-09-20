TWILIO_CONFIG = YAML::load(File.open("#{Rails.root}/config/twilio.yml"))[Rails.env]
