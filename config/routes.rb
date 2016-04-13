Rails.application.routes.draw do
  root 'parser#show'
  get 'fill' => 'parser#fill_base'
end
