Txi::Application.routes.draw do
  resources :menus
  root :to => "menus#index"
end