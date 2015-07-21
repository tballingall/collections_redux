require 'feature_helper'

RSpec.feature 'A user can vist the homepage' do
  context 'as a non-credentialed user I' do
    scenario 'can visit the homepage' do
      visit root_url
      expect(page).to have_content 'Welcome'
    end
  end
end
