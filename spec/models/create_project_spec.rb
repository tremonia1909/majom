require 'rails_helper'

describe 'Projects' do
  let!(:user) {FactoryGirl.create :user}

  context 'logged-in user' do
    it 'creates a new project' do

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

      page.should have_content 'Projektmitglieder'
    end


  end

end