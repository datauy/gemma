class Area < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "title", "updated_at"]
  end
end
