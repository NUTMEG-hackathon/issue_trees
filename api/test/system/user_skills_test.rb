require "application_system_test_case"

class UserSkillsTest < ApplicationSystemTestCase
  setup do
    @user_skill = user_skills(:one)
  end

  test "visiting the index" do
    visit user_skills_url
    assert_selector "h1", text: "User Skills"
  end

  test "creating a User skill" do
    visit user_skills_url
    click_on "New User Skill"

    fill_in "Skill", with: @user_skill.skill_id
    fill_in "User", with: @user_skill.user_id
    click_on "Create User skill"

    assert_text "User skill was successfully created"
    click_on "Back"
  end

  test "updating a User skill" do
    visit user_skills_url
    click_on "Edit", match: :first

    fill_in "Skill", with: @user_skill.skill_id
    fill_in "User", with: @user_skill.user_id
    click_on "Update User skill"

    assert_text "User skill was successfully updated"
    click_on "Back"
  end

  test "destroying a User skill" do
    visit user_skills_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User skill was successfully destroyed"
  end
end
