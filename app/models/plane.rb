class Plane < ActiveRecord::Base
  has_many :pilot_planes
  has_many :plane_weapons
  has_many :pilots, through: :pilot_planes
  has_many :weapons, through: :plane_weapons
end
