require "application_system_test_case"

class PronounsTest < ApplicationSystemTestCase
  setup do
    @pronoun = pronouns(:one)
  end

  test "visiting the index" do
    visit pronouns_url
    assert_selector "h1", text: "Pronouns"
  end

  test "creating a Pronoun" do
    visit pronouns_url
    click_on "New Pronoun"

    fill_in "Description", with: @pronoun.description
    click_on "Create Pronoun"

    assert_text "Pronoun was successfully created"
    click_on "Back"
  end

  test "updating a Pronoun" do
    visit pronouns_url
    click_on "Edit", match: :first

    fill_in "Description", with: @pronoun.description
    click_on "Update Pronoun"

    assert_text "Pronoun was successfully updated"
    click_on "Back"
  end

  test "destroying a Pronoun" do
    visit pronouns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pronoun was successfully destroyed"
  end
end
