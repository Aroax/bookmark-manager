require "bookmark"

describe Bookmark do
  let(:name) { double :name }
  let(:url) { double :url }
  # subject(:bookmark) { described_class.new }
  # it "has a name" do
  #   expect(bookmark.name).to eq name
  # end
  # it "has a url" do
  #   expect(bookmark.url).to eq url
  # end
  it 'can add a bookmark' do
    Bookmark.add(name, url)
    bookmarks = Bookmark.show_bookmarks
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.name).to eq "#{name}"
    expect(bookmarks.first.url).to eq "#{url}"
  end

  it 'displays a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # connection.exec("INSERT INTO bookmarks (url, name) VALUES ('http://www.twitter.com/', 'Twitter');")
    # connection.exec("INSERT INTO bookmarks (url, name) VALUES ('http://www.makers.tech/', 'Makers');")
    # connection.exec("INSERT INTO bookmarks (url, name) VALUES ('http://www.askjeeves.com/', 'AskJeeves');")

    bookmark = Bookmark.add("Twitter", "http://www.twitter.com/")
     Bookmark.add("Makers", "http://www.makers.tech/")
     Bookmark.add("AskJeeves", "http://www.askjeeves.com")
    # (name) VALUES ('Makers');")

    bookmarks = Bookmark.show_bookmarks
    #
    # expect(bookmarks).to include(["Makers", "http://www.makers.tech/"])
    # expect(bookmarks).to include(["Twitter", "http://www.twitter.com/"])
    # expect(bookmarks).to include(["AskJeeves", "http://www.askjeeves.com/"])

    expect(bookmarks.length).to eq 3
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.id).to eq bookmark.id
    expect(bookmarks.first.name).to eq 'Twitter'
    expect(bookmarks.first.url).to eq 'http://www.twitter.com/'

  end

end
