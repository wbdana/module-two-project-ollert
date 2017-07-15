require 'rails_helper'

describe 'homepage' do

  it 'makes sure no infomation is displayed unless logging in' do
    visit "/stores"
    expect(page).to have_content("Please login:")
    visit "/employee"
    expect(page).to have_content("Please login:")
    visit "/shifts"
    expect(page).to have_content("Please login:")
  end

  it 'can login as an manager' do
    visit "/login"
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page).to have_content("Flagship")
  end

  it 'displays invalid login if login is incorrect' do
    visit "/login"
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "1234"
    click_button 'Submit'

    expect(page).to have_content("Invalid")
  end

  it 'can login as an employee' do
    visit "/login"
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page).to have_content("Employee Profile")
  end

  it 'can display all store shift' do
    visit "/login"
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts"

    expect(page).to have_content("Here are the shifts for the Flagship ")

  end

  it 'make new shifts as manager' do
    visit "/login"
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts/new"
    fill_in "shift[day]", with: "2017/08/08"
    select "1:00", :from => "shift[start_time]"
    select "5:00", :from => "shift[end_time]"
    select "Johann", :from => "shift[manager_id]"
    check "shift_employee_ids_9"
    fill_in "shift[tasks_attributes][0][description]", with: "Stock Shelves"
    click_button 'Create Shift'

    expect(page).to have_content("Tuesday, August 8, 2017")
  end

  it 'manager can view shifts of stores' do
    visit "/login"
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts/"

    expect(page).to have_content("Here are the shifts for the Flagship ")
  end

end
#
# describe 'login_success as manager' do
#
# end
