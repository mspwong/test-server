TestServer::Application.routes.draw do

  root to: 'default#here'

  post '/post-json' => 'default#post_json'
  post '/post-hash' => 'default#post_hash'
end
