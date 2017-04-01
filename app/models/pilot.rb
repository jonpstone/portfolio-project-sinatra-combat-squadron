class Pilot < ActiveRecord::Base
  has_many :pilot_planes
  has_many :planes, through: :pilot_planes
end
