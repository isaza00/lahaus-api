class Property < ApplicationRecord
  belongs_to :user
  has_many :photos
  validates :user_id, presence: true
  validates :built_type, inclusion: { in: %w(Casa Apartamento Apartaestudio Lote Penthouse Loft Duplex Casafinca)}, allow_nil: true
  validates :city, length: { maximum: 255 }, allow_nil: true
  validates :price, length: { minimum: 7, maximum: 12 }, allow_nil: true
  validates :address, length: { maximum: 255 }, allow_nil: true
  validates :admon, length: { maximum: 8 }, allow_nil: true
  validates :build_area, length: { maximum: 255 }, allow_nil: true
  validates :private_area, length: { maximum: 255 }, allow_nil: true
  validates :social_class, inclusion: { in: %w(1 2 3 4 5 6 Industrial) }, allow_nil: true
  validates :state, length: { maximum: 255 }, allow_nil: true
  validates :elevator, inclusion: { in: [true, false] }, allow_nil: true
  validates :common_areas, length: { maximum: 255 }, allow_nil: true
  validates :property_tax, length: { minimum: 6, maximum: 12 }, allow_nil: true
  validates :rooms, length: { maximum: 3 }, allow_nil: true
  validates :bathrooms, length: { maximum: 2 }, allow_nil: true
  validates :half_bathrooms, length: { maximum: 2 }, allow_nil: true
  validates :parking_lot, length: { maximum: 2 }, allow_nil: true
  validates :utility_room, inclusion: { in: [true, false] }, allow_nil: true
  validates :empty_property, inclusion: { in: [true, false] }, allow_nil: true
  validates :inhabitants, inclusion: { in: [true, false] }, allow_nil: true
  validates :rent, length:  { maximum: 8 }, allow_nil: true
  validates :mortgage, length:  { maximum: 8 }, allow_nil: true

end
