Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0', namespace: 'blog_sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0', namespace: 'blog_sidekiq' }
end
