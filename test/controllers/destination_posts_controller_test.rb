require "test_helper"

class DestinationPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @destination_post = destination_posts(:one)
  end

  test "should get index" do
    get destination_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_destination_post_url
    assert_response :success
  end

  test "should create destination_post" do
    assert_difference('DestinationPost.count') do
      post destination_posts_url, params: { destination_post: { link: @destination_post.link, name: @destination_post.name } }
    end

    assert_redirected_to destination_post_url(DestinationPost.last)
  end

  test "should show destination_post" do
    get destination_post_url(@destination_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_destination_post_url(@destination_post)
    assert_response :success
  end

  test "should update destination_post" do
    patch destination_post_url(@destination_post), params: { destination_post: { link: @destination_post.link, name: @destination_post.name } }
    assert_redirected_to destination_post_url(@destination_post)
  end

  test "should destroy destination_post" do
    assert_difference('DestinationPost.count', -1) do
      delete destination_post_url(@destination_post)
    end

    assert_redirected_to destination_posts_url
  end
end
