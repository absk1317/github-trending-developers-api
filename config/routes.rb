Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :trends do
        get :developers
      end
    end
  end
end
