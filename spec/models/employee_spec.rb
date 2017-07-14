require 'rails_helper'

describe 'homepage' do
  it 'displays the login page' do
    visit "/login"

    expect(page.status_code).to eq(200)
  end

  it 'can login as an employee' do
    visit "/login"
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page).to have_selector("h4")
  end

end
#
# describe 'login_success as manager' do
#
# end
