Rails.application.routes.draw do

  root 'highschools#index'
  
  resources :highschools do
  	resources :mathclasses
  end

end
