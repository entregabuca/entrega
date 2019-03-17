require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @user = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "creating a Company" do
    visit companies_url
    click_on "New Company"

    fill_in "Email", with: @user.email
    fill_in "Name", with: @user.name
    fill_in "Radius", with: @user.radius
    fill_in "Status", with: @user.status
    fill_in "Telephone", with: @user.telephone
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end

  test "updating a Company" do
    visit companies_url
    click_on "Edit", match: :first

    fill_in "Email", with: @user.email
    fill_in "Name", with: @user.name
    fill_in "Radius", with: @user.radius
    fill_in "Status", with: @user.status
    fill_in "Telephone", with: @user.telephone
    click_on "Update Company"

    assert_text "Company was successfully updated"
    click_on "Back"
  end

  test "destroying a Company" do
    visit companies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company was successfully destroyed"
  end
end
