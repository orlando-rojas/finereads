require 'sinatra'
require 'sinatra/reloader'
require 'http'
require 'guard'
require 'rack-livereload'
require 'Lazyrecord'
require 'date'
require_relative 'model/Book'

use Rack::LiveReload if development?

@@key = "AIzaSyC8xY7H9mf9HVrAmFPcb66v9hWeW4asmBU"
helpers do  
    def get_books(params)
        JSON.parse(HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{params}&key=#{@@key}").body)
    end

    def get_specific_book(id)
        JSON.parse(HTTP.get("https://www.googleapis.com/books/v1/volumes/#{id}?key=#{@@key}").body)
    end

    def get_params(id)
        book_json = get_specific_book(id)
        arr = {}
        arr["img"] = book_json["volumeInfo"]["imageLinks"]["thumbnail"]
        arr["title"] = book_json["volumeInfo"]["title"]
        arr["author"] = book_json["volumeInfo"]["authors"]
        arr
    end
end


get "/" do
    erb :index
end

get "/search" do
    @search = params.fetch("q",'').split(" ").join("+")
    @books = @search.empty? ? [] : get_books(@search)
    erb :search
end

get "/search/:id&:status" do
    id = params["id"]
    status = params["status"]
    par = get_params(id)
    Book.create(par["img"], par["title"], par["author"], status)
    redirect "books"
end

get "/books/:book_id" do
  book = File.open('book.json'){|f|JSON.parse(f.read)}
  erb :book_details, locals: {book:book}
end

get "/books" do
    @my_books = Book.all
    erb :books
end

get "/books/:book_id/edit" do
erb :book_details_edit
end

get "/books/:book_id/delete" do
    book_id = params[:"book_id"].to_i
    Book.delete(book_id)
    redirect 'books'
end