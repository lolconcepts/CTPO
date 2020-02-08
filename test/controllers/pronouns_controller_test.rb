require 'test_helper'

class PronounsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pronoun = pronouns(:one)
  end

  test "should get index" do
    get pronouns_url
    assert_response :success
  end

  test "should get new" do
    get new_pronoun_url
    assert_response :success
  end

  test "should create pronoun" do
    assert_difference('Pronoun.count') do
      post pronouns_url, params: { pronoun: { description: @pronoun.description } }
    end

    assert_redirected_to pronoun_url(Pronoun.last)
  end

  test "should show pronoun" do
    get pronoun_url(@pronoun)
    assert_response :success
  end

  test "should get edit" do
    get edit_pronoun_url(@pronoun)
    assert_response :success
  end

  test "should update pronoun" do
    patch pronoun_url(@pronoun), params: { pronoun: { description: @pronoun.description } }
    assert_redirected_to pronoun_url(@pronoun)
  end

  test "should destroy pronoun" do
    assert_difference('Pronoun.count', -1) do
      delete pronoun_url(@pronoun)
    end

    assert_redirected_to pronouns_url
  end
end
