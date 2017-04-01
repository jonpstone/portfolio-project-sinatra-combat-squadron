class PlaneWeapon < ActiveRecord::Base
  belongs_to :plane
  belongs_to :weapon
end
