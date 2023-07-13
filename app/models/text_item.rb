class TextItem < ApplicationRecord
  belongs_to :section
  belongs_to :chapter
  belongs_to :book
  has_neighbors :embedding
end
