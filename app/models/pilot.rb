class Pilot < ActiveRecord::Base
  has_secure_password
  has_many :pilot_planes
  has_many :planes, through: :pilot_planes

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Pilot.all.detect{|p| p.slug == slug}
  end
end
