require 'sinatra'
require 'http'
require 'guard'
require 'rack-livereload'

use Rack::LiveReload if development?

get "/" do
erb :index
end

get "/search" do
erb :search
end

get "/books/:book_id" do
erb :book_details
end

get "/books" do
erb :books
end

get "/books/:book_id/edit" do
erb :book_details_edit
end

