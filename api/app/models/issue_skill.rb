class IssueSkill < ApplicationRecord
  belongs_to : skill
  belongs_to : issue
end
