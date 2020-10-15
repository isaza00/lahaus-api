class User < ApplicationRecord

  has_many :properties, dependent: :destroy

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d{10}\z/
  validates :email, presence: true,
            length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false },
            allow_nil: false, on: :create
  validates :email, presence: true,
            length: { maximum: 255 },
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: { case_sensitive: false },
            allow_nil: true, on: :update
  validates :password, presence: true,
            length: { minimum: 4, maximum: 255 },
            allow_nil: false, on: :create
  validates :password, presence: true,
            length: { minimum: 4, maximum: 255 },
            allow_nil: true, on: :update
  validates :full_name, presence: true,
            length: { minimum: 3, maximum: 255 },
            allow_nil: false, on: :create
  validates :full_name, presence: true,
            length: { minimum: 3, maximum: 255 },
            allow_nil: true, on: :update
  validates :cellphone, presence: true,
            length: { maximum: 10 },
            format: { with: VALID_PHONE_REGEX},
            allow_nil: false, on: :create
  validates :cellphone, presence: true,
            length: { maximum: 10 },
            format: { with: VALID_PHONE_REGEX},
            allow_nil: true, on: :update
end
