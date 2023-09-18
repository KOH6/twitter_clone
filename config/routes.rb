# frozen_string_literal: true

Rails.application.routes.draw do
  # 開発環境でブラウザ上でメール受信できるようにする
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :posts, only: %i[index]
  resources :users, only: %i[show]

  root 'posts#index'
end
