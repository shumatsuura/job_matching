Rails.application.routes.draw do
  root 'statics#landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  resources :users, only:[:show,:index,:edit,:update] do
    member do
      get :dashboard
    end
  end

end
