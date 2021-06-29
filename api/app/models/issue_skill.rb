class IssueSkill < ApplicationRecord
  belongs_to : skill
  belongs_to : issues
end
