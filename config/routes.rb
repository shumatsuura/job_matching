Rails.application.routes.draw do
  root 'statics#landing'

  devise_for :companies, controllers: {
        sessions: 'companies/sessions'
      }

  devise_for :users, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
      }

  resources :statics, only:[] do
    collection do
      get :landing
      get :landing_for_company
    end
  end

  resources :users, only:[:show,:index,:edit,:update] do
    member do
      get :dashboard
    end
  end

  namespace :admin do
    resources :users do
      collection do
        get :dashboard
      end
    end

    resources :companies
    resources :posts, only:[:index, :destroy]
    resources :scouts, only:[:index, :destroy] do
      resources :scout_messages, only:[:index, :destroy]
    end

    resources :scout_messages, only:[] do
      collection do
        get :index_all
      end
    end

    resources :applies, only:[:index, :destroy] do
      resources :apply_messages, only:[:index, :destroy]
    end

    resources :apply_messages, only:[] do
      collection do
        get :index_all
      end
    end
  end

  resources :companies, only:[:show,:index,:edit,:update] do
    member do
      get :dashboard
    end
  end

  resources :posts do
    member do
      get :manage
    end
  end

  resources :scouts, only:[:index, :create, :destroy] do
    resources :scout_messages, only:[:index, :create]
  end

  resources :applies, only:[:index, :create, :destroy] do
    resources :apply_messages, only:[:index, :create]
  end

  resources :follows, only:[:index,:create,:destroy]
  resources :like_posts, only:[:index,:create,:destroy]
  resources :like_users, only:[:index,:create,:destroy]

end
