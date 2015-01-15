require 'spec_helper'

describe 'Anmeldung' do

  context 'existing user' do
    let!(:user) {FactoryGirl.create :user}


  it 'should User anmelden' do
    click_link 'Sign Up'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: 'monkey123'
      page.should have_content 'Willkommen #{user.email}'

  end
  end
end