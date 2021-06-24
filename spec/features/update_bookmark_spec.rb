feature 'Updating bookmarks' do
  scenario 'a user can update a bookmark' do
    Bookmark.add("Makers", "http://www.makers.tech")
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makers.tech')
    first('.bookmark').click_button 'Update'
    fill_in(:url, with: 'http://www.makersacademy.com')
    click_button('Submit')
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'http://www.makers.tech')
    expect(page).to have_link('Makers', href: 'http://www.makersacademy.com')
  end
end
