class Question < ApplicationRecord
  has_many :poll_questions
  has_many :polls, through: :poll_questions

  belongs_to :section

  has_many :options
  accepts_nested_attributes_for :options, :allow_destroy => true

  belongs_to :semaphore, touch: true
  accepts_nested_attributes_for :semaphore, :allow_destroy => true

  enum :qtype, ['Opciones','Numérica','Texto','Adjunto']

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "qtype", "section", "title", "updated_at", "section_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["options", "poll_questions", "polls", "semaphore"]
  end
end
