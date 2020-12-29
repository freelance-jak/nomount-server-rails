# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :events, except: :show
    resources :members, only: :create
    mount_devise_token_auth_for "User", at: "auth", controllers: {
      registrations: "api/auth/registrations",
    }
  end
end
