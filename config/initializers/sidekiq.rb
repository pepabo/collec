Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{Settings.redis.host}:6379", namespace: 'sidekiq' }
end
