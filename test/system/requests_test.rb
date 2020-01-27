require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
  setup do
    @request = requests(:one)
  end

  test "visiting the index" do
    visit requests_url
    assert_selector "h1", text: "Requests"
  end

  test "creating a Request" do
    visit requests_url
    click_on "New Request"

    check "Call back" if @request.call_back
    fill_in "Email", with: @request.email
    fill_in "Phone", with: @request.phone
    fill_in "Reason", with: @request.reason
    check "Visit" if @request.visit
    fill_in "Who", with: @request.who
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "updating a Request" do
    visit requests_url
    click_on "Edit", match: :first

    check "Call back" if @request.call_back
    fill_in "Email", with: @request.email
    fill_in "Phone", with: @request.phone
    fill_in "Reason", with: @request.reason
    check "Visit" if @request.visit
    fill_in "Who", with: @request.who
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "destroying a Request" do
    visit requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request was successfully destroyed"
  end
end
