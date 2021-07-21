require "application_system_test_case"

class DestinationPostsTest < ApplicationSystemTestCase
  setup do
    @destination_post = destination_posts(:one)
  end

  test "visiting the index" do
    visit destination_posts_url
    assert_selector "h1", text: "Destination Posts"
  end

  test "creating a Destination post" do
    visit destination_posts_url
    click_on "New Destination Post"

    fill_in "Link", with: @destination_post.link
    fill_in "Name", with: @destination_post.name
    click_on "Create Destination post"

    assert_text "Destination post was successfully created"
    click_on "Back"
  end

  test "updating a Destination post" do
    visit destination_posts_url
    click_on "Edit", match: :first

    fill_in "Link", with: @destination_post.link
    fill_in "Name", with: @destination_post.name
    click_on "Update Destination post"

    assert_text "Destination post was successfully updated"
    click_on "Back"
  end

  test "destroying a Destination post" do
    visit destination_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Destination post was successfully destroyed"
  end
end
