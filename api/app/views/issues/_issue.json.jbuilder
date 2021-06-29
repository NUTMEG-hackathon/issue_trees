json.extract! issue, :id, :name, :ancestry, :project_id, :user_id, :description, :level, :created_at, :updated_at
json.url issue_url(issue, format: :json)
