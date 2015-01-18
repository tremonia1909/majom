require 'spec_helper'

describe 'Abmeldung' do

  it 'should User abmelden' do

    click_link 'Sign out'
    page.should have_content 'Erfolgreich abgemeldet'
    true.should == false
  end
end