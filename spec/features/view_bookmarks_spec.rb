require "pg"

feature "Viewing bookmarks" do
  scenario "seeing bookmarks" do
    visit("/bookmarks")
    expect(page).to have_content "Bookmarks:"
  end
  
  scenario "seeing list of bookmarks" do
    connection = PG.connect(dbname: "bookmark_manager_test")

    connection.exec("INSERT INTO bookmarks (url, name) VALUES ('http://www.twitter.com/', 'Twitter');")
    connection.exec("INSERT INTO bookmarks (url, name) VALUES ('http://www.makers.tech/', 'Makers');")
    connection.exec("INSERT INTO bookmarks (url, name) VALUES ('http://www.askjeeves.com/', 'AskJeeves');")

    visit("/bookmarks")
    expect(page).to have_link('Makers', href: 'http://www.makers.tech/')
    expect(page).to have_link('Twitter', href: 'http://www.twitter.com/')
    expect(page).to have_link('AskJeeves', href: 'http://www.askjeeves.com/')
  end
end
