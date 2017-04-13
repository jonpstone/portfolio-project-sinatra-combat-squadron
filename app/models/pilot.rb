class Pilot < ActiveRecord::Base
  has_secure_password
  has_many :pilot_planes
  has_many :planes, through: :pilot_planes
end
