class Evaluation < ApplicationRecord
  belongs_to :poll
  belongs_to :company

  has_many :evaluation_questions, dependent: :delete_all
  accepts_nested_attributes_for :evaluation_questions, :allow_destroy => true

  def self.ransackable_attributes(auth_object = nil)
    ["company_id", "created_at", "id", "id_value", "is_submitted", "poll_id", "submitted_date", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["company", "evaluation_questions", "poll"]
  end

end
