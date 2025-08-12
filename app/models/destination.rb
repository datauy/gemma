class Destination < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "updated_at", "weight"]
  end
end
