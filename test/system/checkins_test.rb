require "application_system_test_case"

class CheckinsTest < ApplicationSystemTestCase
  setup do
    @checkin = checkins(:one)
  end

  test "visiting the index" do
    visit checkins_url
    assert_selector "h1", text: "Checkins"
  end

  test "creating a Checkin" do
    visit checkins_url
    click_on "New Checkin"

    fill_in "User", with: @checkin.user_id
    click_on "Create Checkin"

    assert_text "Checkin was successfully created"
    click_on "Back"
  end

  test "updating a Checkin" do
    visit checkins_url
    click_on "Edit", match: :first

    fill_in "User", with: @checkin.user_id
    click_on "Update Checkin"

    assert_text "Checkin was successfully updated"
    click_on "Back"
  end

  test "destroying a Checkin" do
    visit checkins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Checkin was successfully destroyed"
  end
end
