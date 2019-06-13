require 'test_helper'

class EpaycoControllerTest < ActionDispatch::IntegrationTest
  test "should get result" do
    get epayco_result_url
    assert_response :success
  end

  test "should get confirmation" do
    get epayco_confirmation_url
    assert_response :success
  end

end
