class Pilot < ActiveRecord::Base
  has_many :pilot_planes
  has_many :planes, through: :pilot_planes

  has_secure_password
  validates :username, :email, presence: true, uniqueness: true
end
