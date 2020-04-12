Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'statics#landing'

  devise_for :companies, controllers: {
        sessions: 'companies/sessions'
      }

  devise_for :users, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions',

        omniauth_callbacks: "users/omniauth_callbacks"
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
      get :edit_basic_profile
      get :edit_work_experience
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

  resources :contacts, only:[:new,:create]
  resources :notifications, only:[:index,:show] do
    collection do
      get :change_to_read
    end
  end

end
