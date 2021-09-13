require "test_helper"

class BrandControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brand_index_url
    assert_response :success
  end

  test "should get detail" do
    get brand_detail_url
    assert_response :success
  end
end
