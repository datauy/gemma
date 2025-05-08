class PollQuestion < ApplicationRecord
  belongs_to :poll
  belongs_to :question
  has_one :semaphore

  enum :condition_operator, {'Igual': 1, 'Mayor': 2, 'Menor':3}
end
