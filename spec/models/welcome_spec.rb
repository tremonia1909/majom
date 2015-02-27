require 'rails_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit '/'

    page.should have_title ('Majom')
  end
end