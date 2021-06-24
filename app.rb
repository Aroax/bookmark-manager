require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require_relative "lib/bookmark"
require "uri"
# require_relative "lib/bookmark_list"

class BookmarkManager < Sinatra::Base
  register Sinatra::Flash
  enable :sessions, :method_override


  get "/" do
    # session[:last_deleted] = nil
    redirect "/bookmarks"
  end

  get "/bookmarks" do
    @bookmarks = Bookmark.show_bookmarks
    # @last_deleted = session[:last_deleted]
    erb :bookmarks
  end

  get "/bookmarks/new" do
    # @flash = flash[:notice]
    erb :add_bookmark
  end

  post "/bookmarks/add" do
    if params[:url] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.add(params[:name], params[:url])
    else
      flash[:notice] = "Please enter a valid URL"
    end

    redirect('/bookmarks')
  end

  delete "/bookmarks/:id" do
    # session[:last_deleted] = Bookmark.find(params[:id])
    Bookmark.delete(params[:id])
    #  connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec_params("DELETE FROM bookmarks WHERE id = $1", [params[:id]])
    redirect '/bookmarks'
  end

  get "/bookmarks/:id/update" do
    @bookmark = Bookmark.find(params[:id])
    erb :update_form
  end

  patch "/bookmarks/:id" do
    Bookmark.update(id: params[:id], name: params[:name], url: params[:url])
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
