class Photo < ApplicationRecord

  belongs_to :property
  validates :property_id, presence: true
  validates :url, presence: true

end
