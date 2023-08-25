require 'sidekiq/pro/web'
require 'sidekiq-pro'

Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"

  POOL1 = Sidekiq::RedisConnection.create(url: "redis://localhost:6379/0", timeout: 60)
  POOL2 = Sidekiq::RedisConnection.create(url: "redis://localhost:6379/1", timeout: 60)
  POOL3 = Sidekiq::RedisConnection.create(url: "redis://localhost:6379/2", timeout: 60)
  mount Sidekiq::Pro::Web.with(redis_pool: POOL1), at: '/sidekiq_1'
  mount Sidekiq::Pro::Web.with(redis_pool: POOL2), at: '/sidekiq_2'
  mount Sidekiq::Pro::Web.with(redis_pool: POOL2), at: '/sidekiq_3'
end
