class Option < ApplicationRecord
  belongs_to :question

  enum :otype, ['Opciones','Numérica','Texto','Adjunto']
end
