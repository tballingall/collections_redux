require 'feature_helper'

RSpec.feature 'Edit User' do
  context 'I am a member I am logged in' do
    let!(:member) { create(:user) }
    let!(:other_user) { create(:user) }

    context 'I can edit my own information' do
      scenario 'should be able to edit my info using appropriate data' do
        log_in(member)
        visit edit_user_path(member)
        fill_in 'Name', with: 'another name'
        click_button('Submit')
        expect(page).to have_content('Successfully Updated')
      end
    end

    context 'I try to edit information that is not mine' do
      scenario "I can't edit and should be forwarded to homepage with error" do
        log_in(member)
        visit edit_user_path(other_user)
        expect(page).to have_content('current_user')
      end
    end
  end

  context 'I am not logged in' do
    let!(:user) { create(:user) }

    scenario 'should be able to view profiles' do
      visit users_path
      expect(page).to have_content('Index of Users')
    end
    scenario 'should not be able to edit profiles' do
      visit edit_user_path(user)
      expect(page).to have_content('Login')
    end
  end

  context 'I am a logged in admin' do
    let!(:admin) { create_current_admin }
    let!(:other_user) { create(:user) }
    scenario 'I can edit user information' do
      visit user_path(other_user)
      click_link('Edit')
      fill_in 'Name', with: 'not your name'
      click_button('Submit')
      expect(page).to have_content('not your name')
    end
  end
end
