require "application_system_test_case"

class ProjectUsersTest < ApplicationSystemTestCase
  setup do
    @project_user = project_users(:one)
  end

  test "visiting the index" do
    visit project_users_url
    assert_selector "h1", text: "Project Users"
  end

  test "creating a Project user" do
    visit project_users_url
    click_on "New Project User"

    fill_in "Name", with: @project_user.name
    click_on "Create Project user"

    assert_text "Project user was successfully created"
    click_on "Back"
  end

  test "updating a Project user" do
    visit project_users_url
    click_on "Edit", match: :first

    fill_in "Name", with: @project_user.name
    click_on "Update Project user"

    assert_text "Project user was successfully updated"
    click_on "Back"
  end

  test "destroying a Project user" do
    visit project_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project user was successfully destroyed"
  end
end
