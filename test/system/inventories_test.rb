require "application_system_test_case"

class InventoriesTest < ApplicationSystemTestCase
  setup do
    @inventory = inventories(:one)
  end

  test "visiting the index" do
    visit inventories_url
    assert_selector "h1", text: "Inventories"
  end

  test "creating a Inventory" do
    visit inventories_url
    click_on "New Inventory"

    check "Active" if @inventory.active
    fill_in "Item", with: @inventory.item
    fill_in "Location", with: @inventory.location
    fill_in "Serial number", with: @inventory.serial_number
    fill_in "Warranty ends", with: @inventory.warranty_ends
    click_on "Create Inventory"

    assert_text "Inventory was successfully created"
    click_on "Back"
  end

  test "updating a Inventory" do
    visit inventories_url
    click_on "Edit", match: :first

    check "Active" if @inventory.active
    fill_in "Item", with: @inventory.item
    fill_in "Location", with: @inventory.location
    fill_in "Serial number", with: @inventory.serial_number
    fill_in "Warranty ends", with: @inventory.warranty_ends
    click_on "Update Inventory"

    assert_text "Inventory was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory" do
    visit inventories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory was successfully destroyed"
  end
end
