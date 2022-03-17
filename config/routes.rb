Rails.application.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
    	resources :reports
    	resources :component_item_questions
    	resources :questions
    	resources :component_items
		  resources :components
		  resources :machines
		  resources :shifts
		  resources :users
		  resources :tenants
		  
		  post 'auth/register', to: 'users#register'
          post 'auth/login', to: 'users#login'

		  get 'check_status' => 'tenants#check_status'
		  get 'execute_file' => 'component_items#execute_file'

		  get 'select_component' => 'machines#select_comp'
		  get 'select_comp_item' => 'component_items#select_comp_item'

		  post 'upload_component_questions' => 'component_item_questions#upload_component_questions'
          get 'com_ques_list' => 'component_items#com_ques_list'
 		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
