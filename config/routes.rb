Rails.application.routes.draw do
  root 'statics#landing'

  devise_for :companies, controllers: {
        sessions: 'companies/sessions'
      }

  devise_for :users, controllers: {
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

  resources :companies, only:[:show,:index,:edit,:update] do
    member do
      get :dashboard
    end
  end

  resources :posts

  resources :scouts, only:[:index, :create, :destroy] do
    resources :scout_messages
  end

  resources :applies, only:[:index, :create, :destroy] do
    resources :apply_messages
  end

  resources :follows, only:[:index,:create,:destroy]
  resources :like_posts, only:[:index,:create,:destroy]
  resources :like_users, only:[:index,:create,:destroy]

end
