require "application_system_test_case"

class IssueSkillsTest < ApplicationSystemTestCase
  setup do
    @issue_skill = issue_skills(:one)
  end

  test "visiting the index" do
    visit issue_skills_url
    assert_selector "h1", text: "Issue Skills"
  end

  test "creating a Issue skill" do
    visit issue_skills_url
    click_on "New Issue Skill"

    fill_in "Issue", with: @issue_skill.issue_id
    fill_in "Skill", with: @issue_skill.skill_id
    click_on "Create Issue skill"

    assert_text "Issue skill was successfully created"
    click_on "Back"
  end

  test "updating a Issue skill" do
    visit issue_skills_url
    click_on "Edit", match: :first

    fill_in "Issue", with: @issue_skill.issue_id
    fill_in "Skill", with: @issue_skill.skill_id
    click_on "Update Issue skill"

    assert_text "Issue skill was successfully updated"
    click_on "Back"
  end

  test "destroying a Issue skill" do
    visit issue_skills_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Issue skill was successfully destroyed"
  end
end
