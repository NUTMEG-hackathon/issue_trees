require "test_helper"

class UserSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_skill = user_skills(:one)
  end

  test "should get index" do
    get user_skills_url
    assert_response :success
  end

  test "should get new" do
    get new_user_skill_url
    assert_response :success
  end

  test "should create user_skill" do
    assert_difference('UserSkill.count') do
      post user_skills_url, params: { user_skill: { skill_id: @user_skill.skill_id, user_id: @user_skill.user_id } }
    end

    assert_redirected_to user_skill_url(UserSkill.last)
  end

  test "should show user_skill" do
    get user_skill_url(@user_skill)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_skill_url(@user_skill)
    assert_response :success
  end

  test "should update user_skill" do
    patch user_skill_url(@user_skill), params: { user_skill: { skill_id: @user_skill.skill_id, user_id: @user_skill.user_id } }
    assert_redirected_to user_skill_url(@user_skill)
  end

  test "should destroy user_skill" do
    assert_difference('UserSkill.count', -1) do
      delete user_skill_url(@user_skill)
    end

    assert_redirected_to user_skills_url
  end
end
