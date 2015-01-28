require 'spec_helper'

describe 'Registrierung'    do

  it 'should User registrieren' do
    before(:each) do
          visit root_path
        end

        it 'allows to sign up' do
          click_link 'Sign up'
          fill_in 'user_email', with: 'test@test.de'
          fill_in 'user_password', with: 'monkey123'
          fill_in 'user_password_confirmation', with: 'monkey123'

          expect { click_button 'Sign up' }.to change { User.count }.by(1)

          page.should have_content 'Welcome, test@test.de'

        end
  end
end