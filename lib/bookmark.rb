require "pg"

class Bookmark

  attr_reader :id, :name, :url

  def initialize(id: ,name: ,url: )
    @id  = id
    @name = name
    @url = url
  end

  def self.show_bookmarks
    self.environment
    bookmarks = @connection.exec("SELECT * FROM bookmarks;")
    bookmarks.map { |bookmark| Bookmark.new(id: bookmark['id'], name: bookmark['name'], url: bookmark['url']) }
  end

  def self.add(name, url)
    self.environment
    result = @connection.exec_params("INSERT INTO bookmarks (url, name) VALUES($1, $2) RETURNING id, name, url;", [url, name])
    Bookmark.new(id: result[0]['id'], name: result[0]['name'], url: result[0]['url'])
  end

  def self.delete(id)
    self.environment
    @connection.exec_params("DELETE FROM bookmarks WHERE id = $1;", [id])
  end

  def self.find(id)
    self.environment
    @connection.exec_params("SELECT * FROM bookmarks WHERE id = $1;", [id])
  end


  private

  def self.environment
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "bookmark_manager_test")
    else
      @connection = PG.connect(dbname: "bookmark_manager")
    end
  end

end
