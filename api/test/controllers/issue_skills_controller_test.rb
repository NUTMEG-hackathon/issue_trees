require "test_helper"

class IssueSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue_skill = issue_skills(:one)
  end

  test "should get index" do
    get issue_skills_url
    assert_response :success
  end

  test "should get new" do
    get new_issue_skill_url
    assert_response :success
  end

  test "should create issue_skill" do
    assert_difference('IssueSkill.count') do
      post issue_skills_url, params: { issue_skill: { issue_id: @issue_skill.issue_id, skill_id: @issue_skill.skill_id } }
    end

    assert_redirected_to issue_skill_url(IssueSkill.last)
  end

  test "should show issue_skill" do
    get issue_skill_url(@issue_skill)
    assert_response :success
  end

  test "should get edit" do
    get edit_issue_skill_url(@issue_skill)
    assert_response :success
  end

  test "should update issue_skill" do
    patch issue_skill_url(@issue_skill), params: { issue_skill: { issue_id: @issue_skill.issue_id, skill_id: @issue_skill.skill_id } }
    assert_redirected_to issue_skill_url(@issue_skill)
  end

  test "should destroy issue_skill" do
    assert_difference('IssueSkill.count', -1) do
      delete issue_skill_url(@issue_skill)
    end

    assert_redirected_to issue_skills_url
  end
end
