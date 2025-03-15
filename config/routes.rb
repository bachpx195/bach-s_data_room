Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  namespace :api do
    namespace :v1 do
      resources :charts do
        collection do
          get "effect_hour_candlestick_type_in_day", to: "charts#effect_hour_candlestick_type_in_day"
          get "highest_return_hour_in_day", to: "charts#highest_return_hour_in_day"
        end
      end
      resources :merchandise_rates, only: [:index], defaults: { format: "json" }
      resources :candlesticks, only: [:index], defaults: { format: "json" } do
        member do
          get "info", to: "candlesticks#info"
        end
        collection do
          post "async_update_data", to: "candlesticks#async_update_data"
          get "merchandise_rates", to: "candlesticks#merchandise_rates"
          get "monthly_return", to: "candlesticks#monthly_return"
          get "date_and_hour", to: "candlesticks#date_and_hour", format: 'json'
        end
      end
      resources :event_dates, only: [:index] do
        collection do
          get "list_event", to: "event_dates#list_event"
        end
      end
      resources :patterns, only: [:index, :create] do
        collection do
          get "list_pattern", to: "patterns#list_pattern"
        end
      end
      resources :candlestick_dates do
        collection do
          post "update_metric", to: "candlestick_dates#update_metric"
        end
      end


      # resources :day_analytics, only: [:create], defaults: { format: "json" } do
      #   collection do
      #     post "update_hour_analytic", to: "day_analytics#update_hour_analytic"
      #     get "last_updated_date", to: "day_analytics#last_updated_date"
      #     get "merchandise_rates", to: "day_analytics#merchandise_rates"
      #     post "update_continuous", to: "day_analytics#update_continuous"
      #   end
      # end
      # resources :hour_analytics, only: [:index], defaults: { format: "json" } do
      #   collection do
      #     post "update_continuous", to: "hour_analytics#update_continuous"
      #   end
      # end
      # resources :data_validations, only: [:show], defaults: { format: "json" } do
      #   collection do
      #     get "day_analytics", to: "data_validations#day_analytics"
      #     get "hour_analytics", to: "data_validations#hour_analytics"
      #   end
      # end
    end
  end
end
