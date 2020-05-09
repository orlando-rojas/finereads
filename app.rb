require 'sinatra'
require 'sinatra/reloader'
require 'http'
require 'guard'
require 'rack-livereload'
require 'lazyrecord'
require 'date'
require_relative 'model/Book'

use Rack::LiveReload if development?
@@key = "AIzaSyC8xY7H9mf9HVrAmFPcb66v9hWeW4asmBU"
helpers do  
    def get_books(params)
        JSON.parse(HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{params}&key=#{@@key}").body)
    end
      
    def get_book(id)
        JSON.parse(HTTP.get("https://www.googleapis.com/books/v1/volumes/#{id}&key=#{@@key}").body)
    end
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

@@key = "AIzaSyC8xY7H9mf9HVrAmFPcb66v9hWeW4asmBU"
helpers do
  def get_books(params)
    JSON.parse(HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{params}&key=#{@@key}").body)
  end

  def get_book_no_desc(id)
    url = "https://www.googleapis.com/books/v1/volumes/#{id}?fields=volumeInfo(title,authors,imageLinks/thumbnail)&key=#{@@key}"
    JSON.parse(HTTP.get(url).body)
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
  @search = params.fetch("q", '').split(" ").join("+")
  @books = @search.empty? ? [] : get_books(@search)
  erb :search
end

get "/search/:id&:status" do
  id = params["id"]
  status = params["status"]
  par = get_params(id)
  new_book = Book.new(par["img"], par["title"], par["author"], status, "", id)
  new_book.save
  redirect to("/books")
end

get "/books/:vol_id" do
  book = get_specific_book(params[:vol_id])
  erb :book_details, locals: { book: book }
end

get "/books" do
  @my_books = Book.all
  erb :books
end

get "/books/:book_id/edit" do
  user_data = Book.find(params[:book_id].to_i)
  data = get_book_no_desc(user_data.vol_id)
  erb :book_details_edit, :locals => { :book => data, :user_data => user_data }
end

post "/books/:book_id/edit" do
  book_id = params[:book_id].to_i
  book = Book.find(book_id)
  book.notes = request.POST['note']
  book.status = request.POST['status']
  book.save
  redirect to("/books")
end

get "/books/:book_id/delete" do
  book_id = params[:book_id].to_i
  Book.delete(book_id)
  redirect 'books'
end
