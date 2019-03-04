require "application_system_test_case"

class SendersTest < ApplicationSystemTestCase
  setup do
    @sender = senders(:one)
  end

  test "visiting the index" do
    visit senders_url
    assert_selector "h1", text: "Senders"
  end

  test "creating a Sender" do
    visit senders_url
    click_on "New Sender"

    fill_in "Email", with: @sender.email
    fill_in "Name", with: @sender.name
    fill_in "Status", with: @sender.status
    fill_in "Telephone", with: @sender.telephone
    click_on "Create Sender"

    assert_text "Sender was successfully created"
    click_on "Back"
  end

  test "updating a Sender" do
    visit senders_url
    click_on "Edit", match: :first

    fill_in "Email", with: @sender.email
    fill_in "Name", with: @sender.name
    fill_in "Status", with: @sender.status
    fill_in "Telephone", with: @sender.telephone
    click_on "Update Sender"

    assert_text "Sender was successfully updated"
    click_on "Back"
  end

  test "destroying a Sender" do
    visit senders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sender was successfully destroyed"
  end
end
