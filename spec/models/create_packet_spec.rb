require 'rails_helper'

describe 'Projects' do
  let!(:user) {FactoryGirl.create :user}

  context 'overview' do
    it 'creates a new paket' do

      visit '/users/sign_in/'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'monkey123'
      click_button 'Login'
      visit '/create_project'

      fill_in('project_project_name', :with => 'Namenstesteinszweidrei')
      fill_in('project_budget', :with => '1000')
      fill_in('project_start_date', :with => '04/10/2015')
      fill_in('project_deadline', :with => '06/10/2015')
      fill_in('project_description', :with => 'Lorem ipsum Beschreibung')

      click_button 'Projekt erstellen'

      click_button 'Weiter'

      fill_in('packet_packet_name', :with => 'lalelu')
      fill_in('packet_expenses', :with => '10')
      fill_in('packet_start_date', :with => '04/10/2015')
      fill_in('packet_deadline', :with => '06/10/2015')
      fill_in('packet_description', :with => 'Lorem ipsum Beschreibung')

      click_button 'Paket erstellen'
      click_button 'Fertig'

      page.should have_content 'Aufgaben'



    end
  end
end