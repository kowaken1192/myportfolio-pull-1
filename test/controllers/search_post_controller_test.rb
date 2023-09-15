require "test_helper"

class SearchPostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_post_index_url
    assert_response :success
  end

  test "should get show" do
    get search_post_show_url
    assert_response :success
  end
end
