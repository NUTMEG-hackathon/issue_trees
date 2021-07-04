class Client < ApplicationRecord
  belongs_to :project
  has_many :issues
end
