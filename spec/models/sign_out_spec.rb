require 'spec_helper'

describe 'Abmeldung' do

  context 'logged-in user' do
    let!(:user) {FactoryGirl.create :user}

    it 'should sign in' do

      visit '/users/sign_in/'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'monkey123'
      click_button 'Login'

      click_link('Abmelden')

      page.should have_content 'Majom'
      end
  end
end