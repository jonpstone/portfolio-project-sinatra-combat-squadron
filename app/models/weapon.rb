class Weapon < ActiveRecord::Base
  has_many :plane_weapons
  has_many :planes, through: :plane_weapons

  validates_uniqueness_of :name
  validates_presence_of :name, :classification, :caliber
end
