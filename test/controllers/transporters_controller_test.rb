require 'test_helper'

class TransportersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transporter = transporters(:one)
  end

  test "should get index" do
    get transporters_url
    assert_response :success
  end

  test "should get new" do
    get new_transporter_url
    assert_response :success
  end

  test "should create transporter" do
    assert_difference('Transporter.count') do
      post transporters_url, params: { transporter: { company_id: @transporter.company_id, email: @transporter.email, name: @transporter.name, status: @transporter.status, telephone: @transporter.telephone } }
    end

    assert_redirected_to transporter_url(Transporter.last)
  end

  test "should show transporter" do
    get transporter_url(@transporter)
    assert_response :success
  end

  test "should get edit" do
    get edit_transporter_url(@transporter)
    assert_response :success
  end

  test "should update transporter" do
    patch transporter_url(@transporter), params: { transporter: { company_id: @transporter.company_id, email: @transporter.email, name: @transporter.name, status: @transporter.status, telephone: @transporter.telephone } }
    assert_redirected_to transporter_url(@transporter)
  end

  test "should destroy transporter" do
    assert_difference('Transporter.count', -1) do
      delete transporter_url(@transporter)
    end

    assert_redirected_to transporters_url
  end
end
