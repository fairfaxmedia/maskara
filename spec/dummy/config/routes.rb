Rails.application.routes.draw do
  root to: "home#root"
  get 'main' => "home#main"
  get 'remote' => "mod/sub#remote"
end
