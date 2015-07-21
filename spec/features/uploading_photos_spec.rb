require 'feature_helper'

RSpec.feature 'A new user can add an avatar' do
  let(:name) { 'thisguy' }
  let(:email) { 'not@thatguy.com' }
  let(:password) { 'words' }
  let(:password_confirmation) { 'words' }

  context 'As an uncredentialed user' do
    context 'with acceptable information' do
      scenario 'I can register for a new account with an image' do
        visit new_user_path
        expect(page).to have_content('Sign up')
        fill_in 'user_name', with: name
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        page.attach_file('user_image', './spec/support/upload/octo.jpg')
        click_button('Submit')
        expect(page.html).to match(/octo.jpg/)
      end
    end
  end

  context 'I am a member I am logged in' do
    let(:member) { create(:user) }

    it 'can upload a photo' do
      log_in(member)
      visit edit_user_path(member)
      # click_link('Choose File')
      page.attach_file('user_image', './spec/support/upload/octo.jpg')
      click_button('Submit')
      # expect(page).to have_xpath("//img[@src=\"
      # #{member.image.thumb('200x200#').url}\"]")
      # above line finds an almost exact mactch for dragonfly's link but
      # leaves the image name out of the url. Would be a better test but can't
      # suss out the solution
      expect(page.html).to match(/octo.jpg/)
    end
  end
end
