class User < ApplicationRecord
  has_many: issues
  has_many: project_users
  has_many: user_skills
end
