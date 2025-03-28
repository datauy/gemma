class Question < ApplicationRecord
  has_many :options
  accepts_nested_attributes_for :options, :allow_destroy => true

  enum :qtype, ['Opciones','Numérica','Texto','Adjunto']

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "qtype", "section", "title", "updated_at"]
  end
end
