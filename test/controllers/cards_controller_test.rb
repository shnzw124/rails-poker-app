require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get cards_top_url
    assert_response :success
  end

  test "should get result" do
    get cards_result_url
    assert_response :success
  end

  test "should get error" do
    get cards_error_url
    assert_response :success
  end

end
