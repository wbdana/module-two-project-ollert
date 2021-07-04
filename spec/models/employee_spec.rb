require 'rails_helper'

describe 'links' do

  it 'can visit the login page' do
    visit '/login'

    expect(page.status_code).to eq(200)
  end

  it 'can login and visit the manager homepage' do
    visit '/login'
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page.status_code).to eq(200)
  end

  it 'can login and visit the employee homepage' do
    visit '/login'
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page.status_code).to eq(200)
  end

  it 'can navigate to stores' do
    visit '/login'
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit '/stores'

    expect(page.status_code).to eq(200)
    expect(page).to have_content("Stores:")
  end
end

describe 'employee views' do

  it 'displays shifts for employees on their homepage' do
    visit '/login'
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts/new"
    fill_in "shift[day]", with: "2017/08/08"
    select "1:00", :from => "shift[start_time]"
    select "5:00", :from => "shift[end_time]"
    select "Johann", :from => "shift[manager_id]"
    check "shift_employee_ids_8"
    fill_in "shift[tasks_attributes][0][description]", with: "Stock Shelves"
    click_button 'Create Shift'
    visit '/logout'
    visit '/login'
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page).to have_content("Shifts:")
    expect(page).to have_content("August")

  end

  it 'displays employee tasks on their homepage' do
    visit '/login'
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts/new"
    fill_in "shift[day]", with: "2017/08/08"
    select "1:00", :from => "shift[start_time]"
    select "5:00", :from => "shift[end_time]"
    select "Johann", :from => "shift[manager_id]"
    check "shift_employee_ids_8"
    fill_in "shift[tasks_attributes][0][description]", with: "Stock Shelves"
    click_button 'Create Shift'
    visit '/logout'
    visit '/login'
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page).to have_content("Stock Shelves")

  end

  it 'displays employee future scheduled hours' do
    visit '/login'
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts/new"
    fill_in "shift[day]", with: "2017/08/08"
    select "1:00", :from => "shift[start_time]"
    select "5:00", :from => "shift[end_time]"
    select "Johann", :from => "shift[manager_id]"
    check "shift_employee_ids_8"
    fill_in "shift[tasks_attributes][0][description]", with: "Stock Shelves"
    click_button 'Create Shift'
    visit '/logout'
    visit '/login'
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'

    expect(page).to have_content("Future Scheduled Hours: 4")
  end

end

describe 'manager views' do

  it 'can navigate to manager profile view' do
    visit '/login'
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit '/employees/1'

    expect(page).to have_content("Shifts:")
  end

  it 'shows manager tasks on manager profile view' do
    visit '/login'
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
    visit '/employees/1'

    expect(page).to have_content("Stock Shelves")
  end



end

describe 'homepage' do

# having trouble figuring this out; think we need to run rake:db drop and rake db:setup before each rspec test
  # before(:each) do
  #
  #   end

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

  it 'can display all store shifts' do
    visit "/login"
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/stores/1/shifts"

    expect(page).to have_content("Here are the shifts for the Flagship ")

  end
end

describe 'manager actions' do

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

  it 'manager can add an employee' do
    visit "/login"
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/employees/new"
    fill_in 'employee[name]', :with => "Jimbobgeorge"
    fill_in 'employee[email]', :with => "jimbobgeorge@test.com"
    select "Flagship New York", :from => "employee[store_id]"
    select "Employee", :from => "employee[is_manager]"
    fill_in 'employee[password]', :with => "test"
    fill_in 'employee[password_confirmation]', :with => "test"
    click_button 'Add new employee'

    expect(page).to have_content("Upcoming Tasks")
  end

  it 'manager can view an employee' do
    visit "/login"
    fill_in 'email', :with => "johann@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "/employees/6"

    expect(page).to have_content("Paul Employee Profile")
  end
end

describe 'employee actions' do

  it 'employee cannot create a new employee' do
    visit "/login"
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "employees/new"

    expect(page).to have_content("Will Employee Profile")
  end

  it 'employee cannot create a new shift' do
    visit "/login"
    fill_in 'email', :with => "will@test.com"
    fill_in 'password', :with => "test"
    click_button 'Submit'
    visit "stores/1/shifts/new"

    expect(page).to have_content("Will Employee Profile")
  end

# broken
  # it 'employee cannot delete a shift' do
  #   visit "/login"
  #   fill_in 'email', :with => "johann@test.com"
  #   fill_in 'password', :with => "test"
  #   click_button 'Submit'
  #   visit "/stores/1/shifts/new"
  #   fill_in "shift[day]", with: "2025/01/01"
  #   select "1:00", :from => "shift[start_time]"
  #   select "5:00", :from => "shift[end_time]"
  #   select "Johann", :from => "shift[manager_id]"
  #   check "shift_employee_ids_9"
  #   fill_in "shift[tasks_attributes][0][description]", with: "Stock Shelves"
  #   click_button 'Create Shift'
  #   @shift = Shift.last
  #   visit "/logout"
  #   visit "/login"
  #   fill_in 'email', :with => "will@test.com"
  #   fill_in 'password', :with => "test"
  #   click_button 'Submit'
  #   visit "/shifts/#{@shift.id}/destroy"
  #   visit "/shifts/#{@shift.id}"
  #
  #   # page.should have_selector('input#delete')
  #   # page.find('delete').click
  #
  #   expect(page).to have_content("Will Employee Profile")
  # end

end
