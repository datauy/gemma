class PollQuestion < ApplicationRecord
  belongs_to :poll
  belongs_to :question
end
