class Issue < ApplicationRecord
  has_many :issue_skills
  belongs_to :project
  belongs_to :user
  
end
