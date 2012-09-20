PUSHER_CONFIG = YAML::load(File.open("#{Rails.root}/config/pusher.yml"))[Rails.env]
