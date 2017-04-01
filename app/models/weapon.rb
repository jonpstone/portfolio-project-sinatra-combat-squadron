class Weapon < ActiveRecord::Base
  has_many :plane_weapons
  has_many :planes, through: :plane_weapons
end
