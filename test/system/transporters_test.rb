require "application_system_test_case"

class TransportersTest < ApplicationSystemTestCase
  setup do
    @transporter = transporters(:one)
  end

  test "visiting the index" do
    visit transporters_url
    assert_selector "h1", text: "Transporters"
  end

  test "creating a Transporter" do
    visit transporters_url
    click_on "New Transporter"

    fill_in "Company", with: @transporter.company_id
    fill_in "Email", with: @transporter.email
    fill_in "Name", with: @transporter.name
    fill_in "Status", with: @transporter.status
    fill_in "Telephone", with: @transporter.telephone
    click_on "Create Transporter"

    assert_text "Transporter was successfully created"
    click_on "Back"
  end

  test "updating a Transporter" do
    visit transporters_url
    click_on "Edit", match: :first

    fill_in "Company", with: @transporter.company_id
    fill_in "Email", with: @transporter.email
    fill_in "Name", with: @transporter.name
    fill_in "Status", with: @transporter.status
    fill_in "Telephone", with: @transporter.telephone
    click_on "Update Transporter"

    assert_text "Transporter was successfully updated"
    click_on "Back"
  end

  test "destroying a Transporter" do
    visit transporters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transporter was successfully destroyed"
  end
end
