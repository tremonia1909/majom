require 'spec_helper'

describe 'Anmeldung' do

  context 'existing user' do
    let!(:user) {FactoryGirl.create :user}

    it 'should sign in' do

      visit '/users/sign_in/'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'monkey123'
      click_button 'Login'

      page.should have_content 'Hallo'
    end
  end
end