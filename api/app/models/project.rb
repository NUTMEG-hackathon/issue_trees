class Project < ApplicationRecord
  has_many :clients
  has_many :project_users
end
