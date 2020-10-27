class Photo < ApplicationRecord

  belongs_to :property
  validates :property_id, presence: true
  validates :url, presence: true
  validates :location, presence: true, length: { maximum: 255 }, allow_nil: true

end
