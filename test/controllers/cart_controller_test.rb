require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cart_index_url
    assert_response :success
  end

  test "should get checkout" do
    get cart_checkout_url
    assert_response :success
  end
end
