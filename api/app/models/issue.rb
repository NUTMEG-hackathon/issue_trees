class Issue < ApplicationRecord
  has_many :issue_skills
  belongs_to :client
  belongs_to :user
  
end
