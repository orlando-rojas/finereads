#AIzaSyBzf7YKNXV-vFNANig2AiTGAAkzVb-2Oos
require 'sinatra'
require 'sinatra/reloader' if development?

get '/:path?' do

  if params['path'].nil? || params['path'].to_sym == :news
    cache_control :public, max_age: 1
    erb :index, layout: :layout
  else
    erb params['path'].to_sym, layout: :layout
  end
end