require 'rails_helper'

describe 'Abmeldung' do

  it 'should User sign_up' do


    visit '/index'

      click_link 'Registrieren'
      fill_in 'Benutzername', with: 'test'
      fill_in 'Vorname', with: 'max'
      fill_in 'Nachname', with: 'mustermann'
      fill_in 'user_email', with: 'test@test.de'
      fill_in 'user_password', with: 'monkey123'
      fill_in 'user_password_confirmation', with: 'monkey123'

      expect { click_button 'Registrieren' }.to change { User.count }.by(1)

      page.should have_content 'Welcome'


  end
end