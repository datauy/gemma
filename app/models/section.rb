class Section < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["color", "created_at", "description", "id", "title", "updated_at"]
  end

end
