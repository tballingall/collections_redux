require 'feature_helper'

RSpec.feature 'Managing Images' do
  let!(:user) { create_current_admin }

  context 'As a user with admin rights' do
    scenario 'I can access an index of all images' do
      visit user_path(user)
      click_link 'Admin Review'
      expect(page).to have_content('Image Review')
    end

    scenario 'All images will be in chronological order' do
      visit images_path
      expect(page).to have_

  end

  context 'As a normal user' do
   let!(:other_user) { create_current_user}

   scenario 'I cannot access the admin page' do
     visit images_path
     save_and_open_page
     expect(page).to have_content('Access Denied')
    end
  end
end
