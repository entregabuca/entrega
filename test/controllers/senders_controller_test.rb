require 'test_helper'

class SendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = senders(:one)
  end

  test "should get index" do
    get senders_url
    assert_response :success
  end

  test "should get new" do
    get new_sender_url
    assert_response :success
  end

  test "should create sender" do
    assert_difference('Sender.count') do
      post senders_url, params: { sender: { email: @user.email, name: @user.name, status: @user.status, telephone: @user.telephone } }
    end

    assert_redirected_to sender_url(Sender.last)
  end

  test "should show sender" do
    get sender_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_sender_url(@user)
    assert_response :success
  end

  test "should update sender" do
    patch sender_url(@user), params: { sender: { email: @user.email, name: @user.name, status: @user.status, telephone: @user.telephone } }
    assert_redirected_to sender_url(@user)
  end

  test "should destroy sender" do
    assert_difference('Sender.count', -1) do
      delete sender_url(@user)
    end

    assert_redirected_to senders_url
  end
end
