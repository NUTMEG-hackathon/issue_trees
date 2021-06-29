class User < ApplicationRecord
  has_many: issue
  has_many: project_users
  has_many: user_skills
end
