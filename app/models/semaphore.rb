class Semaphore < ApplicationRecord
  has_one :question
  has_one :poll_section
  has_one :poll_question

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "formula", "green_text", "green_value", "id", "id_value", "red_text", "red_value", "updated_at", "yellow_text"]
  end
end
