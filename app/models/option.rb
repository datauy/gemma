class Option < ApplicationRecord
  belongs_to :question

  enum :otype, [
    'option',
    'numeric',
    'text',
    'attached',
  ]
end
