Rails.application.routes.draw do
  root to: redirect('/witch-calculator')

  get '/witch-calculator', to: 'witch_calculator#index'
  post '/calculate-average-kills', to: 'witch_calculator#calculate_average_kills'
  get '/witch-calculator/result', to: 'witch_calculator#result', as: 'witch_calculator_result'

  get '*path' => redirect('/witch-calculator')
end
