feature 'Removing bookmarks' do
  scenario 'A user can delete a bookmark' do
    Bookmark.add("Makers", "http://www.makers.tech")
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makers.tech')
    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'http://www.makers.tech')
  end
end
