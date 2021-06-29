class Project < ApplicationRecord
  has_many: issues
  has_many: project_users
end
