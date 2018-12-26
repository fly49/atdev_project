Rails.application.routes.draw do
  require 'sidekiq/cron/web'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
  get 'history' => 'home#history'
  get 'convert' => 'home#convert'
end
