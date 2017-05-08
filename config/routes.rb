Rails.application.routes.draw do
  root 'healthchecks#show'

  resource :healthcheck, only: [:show]

  namespace :api do
    resource :prediction, only: [:show]
  end
end
