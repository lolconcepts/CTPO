require "application_system_test_case"

class ChurchesTest < ApplicationSystemTestCase
  setup do
    @church = churches(:one)
  end

  test "visiting the index" do
    visit churches_url
    assert_selector "h1", text: "Churches"
  end

  test "creating a Church" do
    visit churches_url
    click_on "New Church"

    click_on "Create Church"

    assert_text "Church was successfully created"
    click_on "Back"
  end

  test "updating a Church" do
    visit churches_url
    click_on "Edit", match: :first

    click_on "Update Church"

    assert_text "Church was successfully updated"
    click_on "Back"
  end

  test "destroying a Church" do
    visit churches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Church was successfully destroyed"
  end
end
