require 'feature_helper'

RSpec.feature 'Managing Images' do
  context 'given I am authenticated' do
    let!(:user) { create_current_user }
    let(:image_name) { 'Octokitty' }
    context 'and I have an album' do
      let(:album) { create(:album, user: user) }

      scenario 'I can add an image to the album' do
        visit album_path(album)
        click_link 'Add an Image'
        fill_in 'Name', with: image_name
        fill_in 'Color', with: 'So Many'
        fill_in 'Description', with: 'Abomination'
        select 2013, from: 'Year'
        page.attach_file('Image', './spec/support/upload/octo.jpg')
        click_button('Submit')
        expect(page).to have_content('Success')
        expect(page).to have_content image_name
        expect(page.html).to match(/octo.jpg/)
      end

      scenario 'I can see errors with incorrect information' do
        visit new_album_image_path(album)
        page.attach_file('image_image', './spec/support/upload/octo.jpg')
        fill_in 'Name', with: ''
        fill_in 'Color', with: 'Blue'
        fill_in 'Description', with: 'Abomination'
        select 2013, from: 'Year'
        click_button('Submit')
        expect(page).to have_content('error')
      end

      context 'given another users album' do
        let!(:album) { create(:album) }

        scenario 'I cannot add images' do
          visit album_path(album)
          expect(page).to_not have_link('Add Picture')
          visit edit_album_path(album)
          expect(page).to have_content('Access Denied')
        end

        context 'given an image' do
          let!(:image) { create(:image, album: album) }

          scenario 'I cannot set an image primary' do
            visit album_path(album)
            expect(page).to_not have_link('Make Primary')
          end
        end
      end

      context 'given that I have added an image to my album' do
        let!(:image) { create(:image, album: album) }
        let(:new_file) { '/spec/support/upload/octo.jpg' }
        let(:new_image) { "//img[contains(@src, \"octo.jpg\")]" }
        let(:original_image) do
          "//img[contains(@src, \"#{image.image_name}\")]"
        end

        scenario 'The image will be labeled primary' do
          visit user_path(user)
          expect(page).to have_xpath original_image
        end

        scenario 'I can make another image primary' do
          visit user_path(user)
          expect(page).to have_xpath original_image
          expect(page).to_not have_link('Make Primary')
          visit new_album_image_path(album)
          page.attach_file('Image', './spec/support/upload/hulk.jpg')
          fill_in 'Name', with: image_name
          fill_in 'Color', with: 'ROYGBV'
          fill_in 'Description', with: 'Abomination'
          select 2013, from: 'Year'
          click_button('Submit')
          expect(page).to have_content album.name
          expect(page).to have_xpath original_image
          expect(page).to have_xpath new_image
          within("##{dom_id(Image.last)}") do
            click_link('Make Primary')
          end
          visit user_path(user)
          expect(page.html).to match(/hulk.jpg/)
        end
      end
    end
  end
end
