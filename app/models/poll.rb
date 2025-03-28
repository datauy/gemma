class Poll < ApplicationRecord
  belongs_to :area
  belongs_to :provision
  has_many :poll_questions, dependent: :delete_all
  has_many :questions, through: :poll_questions
  accepts_nested_attributes_for :poll_questions, :allow_destroy => true
  #
  def self.ransackable_attributes(auth_object = nil)
    ["area_id", "created_at", "description", "id", "last_disclaimer", "provision_id", "title", "updated_at"]
  end
  #
  def self.ransackable_associations(auth_object = nil)
    ["area", "provision"]
  end
end
