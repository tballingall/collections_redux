require 'feature_helper'

RSpec.feature 'User create' do
  let(:name) { 'thisguy' }
  let(:email) { 'not@thatguy.com' }
  let(:password) { 'words' }
  let(:password_confirmation) { 'words' }

  context 'As an uncredentialed user' do
    context 'with acceptable information' do
      scenario 'I can register for a new account' do
        visit new_user_path
        expect(page).to have_content('Name')
        fill_in 'user_name', with: name
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        click_button 'Submit'
        expect(page).to have_content('Signed Up')
      end
    end
    context 'with unacceptable information' do
      let(:name) { nil }

      scenario 'I can see errors' do
        visit new_user_path
        expect(page).to have_content('Sign up')
        fill_in 'user_name', with: name
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        click_button 'Submit'
        expect(page).to have_content('error')
      end
    end
  end
end
