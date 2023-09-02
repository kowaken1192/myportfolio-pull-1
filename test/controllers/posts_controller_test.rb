require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get indexx" do
    get posts_indexx_url
    assert_response :success
  end
end
