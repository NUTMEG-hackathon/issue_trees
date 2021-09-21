class Client < ApplicationRecord
  belongs_to :project
  has_many :issues
  accepts_nested_attributes_for :issues
end
