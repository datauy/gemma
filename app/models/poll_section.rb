class PollSection < ApplicationRecord
  belongs_to :section
  belongs_to :poll
  belongs_to :semaphore
  accepts_nested_attributes_for :semaphore, :allow_destroy => true
end
