class Issue < ApplicationRecord
  has_many :issue_skills
  has_many :skills, through: :issue_skills
  belongs_to :client
  belongs_to :user

end
