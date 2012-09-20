PUSHER_CONFIG = YAML::load(File.open("#{Rails.root}/config/pusher.yml"))[Rails.env]
Pusher.app_id = PUSHER_CONFIG['app_id']
Pusher.key = PUSHER_CONFIG['key']
Pusher.secret = PUSHER_CONFIG['secret']
