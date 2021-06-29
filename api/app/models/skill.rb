class Skill < ApplicationRecord
  has_many: issue_skills
  has_many: user_skills
end
