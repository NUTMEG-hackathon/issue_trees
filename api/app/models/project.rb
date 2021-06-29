class Project < ApplicationRecord
  has_many: issue
  has_many: project_users
end
