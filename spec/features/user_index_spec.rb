require 'feature_helper'

RSpec.feature 'A user can vist the homepage' do
  context 'I am a member I am logged in' do
    let!(:user) { create_current_user }
    before do
      3.times do
        create(:user)
        2.times do
          create(:admin)
        end
      end
    end

    context 'I can visit index page' do
      before do
        visit users_path
      end

      scenario 'User list is paginated' do
        expect(page).to have_content 'Next'
        click_link(2)
        click_link(1)
      end

      scenario 'Admin\'s have specific icons' do
        expect(page.html).to match('Freedom')
      end

      scenario 'User name links to profile' do
        user = User.first
        expect(page).to have_content 'Index of Users'
        click_link(user.name)
        expect(page).to have_content 'Name'
      end
    end
  end
end
