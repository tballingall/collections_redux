require 'feature_helper'

RSpec.feature 'An authenticated user can add new albums to their account' do
  let(:member) { create(:user) }

  context 'I am a logged in member' do
    scenario 'A link to this image collection will appear on my profile page' do
      log_in(member)
      visit user_path(member)
      expect(page).to have_content('Your Albums')
    end
  end

  context 'I can edit information for my image collection' do
    scenario 'should be able to edit my info using appropriate data' do
      log_in(member)
      visit user_albums_path(member)
      click_link('Create an Album')
      fill_in 'Name', with: 'another name'
      click_button('Submit')
      expect(page).to have_content('another name')
    end
  end

  context 'I cannot edit information for the image collection for others' do
    before do
      log_in(member)
    end
    let(:other_user) { create(:user) }
    scenario "I can't edit and should be forwarded to homepage with error" do
      log_in(member)
      visit user_albums_path(other_user)
      click_link('Create an Album')
      fill_in 'Name', with: 'another name'
      click_button('Submit')
      expect(page).to have_link(member.name)
    end
  end
end
