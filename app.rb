require 'sinatra'
require 'sinatra/reloader'
require 'http'
require 'guard'
require 'rack-livereload'

@@key = "AIzaSyC8xY7H9mf9HVrAmFPcb66v9hWeW4asmBU"
helpers do  
    def get_books(params)
        JSON.parse(HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{params}&key=#{@@key}").body)
    end
end

use Rack::LiveReload if development?

get "/" do
erb :index
end

get "/search" do
    @search = params.fetch("q",'').split(" ").join("+")
    puts "Hola #{@search}"
    @books = @search.empty? ? [] : get_books(@search)
    erb :search
end

get "/books/:book_id" do
  book = File.open('book.json'){|f|JSON.parse(f.read)}
  erb :book_details, locals: {book:book}
end

get "/books" do
erb :books
end

get "/books/:book_id/edit" do
erb :book_details_edit
end

