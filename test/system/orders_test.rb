require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Cost", with: @order.cost
    fill_in "Delivery time", with: @order.delivery_time
    fill_in "Description", with: @order.description
    fill_in "Heigth", with: @order.heigth
    fill_in "Length", with: @order.length
    fill_in "Pickup time", with: @order.pickup_time
    fill_in "Radius", with: @order.radius
    fill_in "Sender", with: @order.sender_id
    fill_in "Status", with: @order.status
    fill_in "Transporter", with: @order.transporter_id
    fill_in "Weight", with: @order.weight
    fill_in "Width", with: @order.width
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Cost", with: @order.cost
    fill_in "Delivery time", with: @order.delivery_time
    fill_in "Description", with: @order.description
    fill_in "Heigth", with: @order.heigth
    fill_in "Length", with: @order.length
    fill_in "Pickup time", with: @order.pickup_time
    fill_in "Radius", with: @order.radius
    fill_in "Sender", with: @order.sender_id
    fill_in "Status", with: @order.status
    fill_in "Transporter", with: @order.transporter_id
    fill_in "Weight", with: @order.weight
    fill_in "Width", with: @order.width
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
