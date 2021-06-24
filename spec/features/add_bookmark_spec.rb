feature 'a user can add new bookmarks' do
  let(:name) { double(:name) }
  let(:url) { double(:url) }

  scenario 'a user adds a bookmark' do
    visit('/bookmarks')
    click_link('Add bookmark')
    fill_in(:name, with: "test")
    fill_in(:url, with: "http://www.test.com")
    click_button('submit')
    expect(page).to have_link("test", href: "http://www.test.com")
  end

  scenario 'bookmark has a valid URL' do
    visit('/bookmarks/new')
    fill_in(:url, with: 'invalid url')
    fill_in(:name, with: name)
    click_button('submit')

    expect(page).to have_content("Please enter a valid URL")
  end
end
