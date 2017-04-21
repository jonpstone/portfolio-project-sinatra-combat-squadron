planes_list = {
    "P-38 Lightning" => {
      :manufacturer => "Lockheed",
      :top_speed => 414,
      :ceiling => 44000,
      :classification => "Fighter"    },
    "P-47 Thunderbolt" => {
      :manufacturer => "Republic",
      :top_speed => 433,
      :ceiling => 43000,
      :classification => "Fighter"    },
    "Bf 109" => {
      :manufacturer => "Messerschmitt",
      :top_speed => 398,
      :ceiling => 39400,
      :classification => "Fighter"    },
    "Mosquito" => {
      :manufacturer => "de Havilland",
      :top_speed => 415,
      :ceiling => 37000,
      :classification => "Bomber"    },
    "Hurricane" => {
      :manufacturer => "Hawker",
      :top_speed => 340,
      :ceiling => 36000,
      :classification => "Fighter-Bomber"    },
    "La-7" => {
      :manufacturer => "Lavochkin",
      :top_speed => 411,
      :ceiling => 34300,
      :classification => "Fighter"    },
    "F6F Hellcat" => {
      :manufacturer => "Grumman",
      :top_speed => 391,
      :ceiling => 37300,
      :classification => "Fighter"    },
    "F4U Corsair" => {
      :manufacturer => "Vought",
      :top_speed => 446,
      :ceiling => 41500,
      :classification => "Fighter-Bomber"    },
    "Spitfire (Griffon)" => {
      :manufacturer => "Supermarine",
      :top_speed => 449,
      :ceiling => 43000,
      :classification => "Fighter"    },
    "P-40 Warhawk" => {
      :manufacturer => "Curtiss",
      :top_speed => 360,
      :ceiling => 29000,
      :classification => "Fighter"    },
    "Spitfire (Merlin)" => {
      :manufacturer => "Supermarine",
      :top_speed => 404,
      :ceiling => 40000,
      :classification => "Fighter"    },
    "Gladiator" => {
      :manufacturer => "Gloster",
      :top_speed => 253,
      :ceiling => 32800,
      :classification => "Fighter"    },
    "B-239 Buffalo" => {
      :manufacturer => "Brewster",
      :top_speed => 321,
      :ceiling => 33200,
      :classification => "Fighter"    }
  }

planes_list.each do |name, params_hash|
  p = Plane.new
  p.name = name
  params_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

weapons_list = {
    "Hispano Mk.II" => {
      :classification => "Cannon",
      :caliber => "20mm"
    },
    "M2 Browning" => {
      :classification => "Machine Gun",
      :caliber => ".50"
    },
    "Light Bomb" => {
      :classification => "Free fall HE",
      :caliber => "250lbs"
    },
    "Medium Bomb" => {
      :classification => "Free fall HE",
      :caliber => "500lbs"
    },
    "Heavy Bomb" => {
      :classification => "Free fall HE",
      :caliber => "1000lbs"
    },
    "Upkeep Bomb" => {
      :classification => "Bouncing",
      :caliber => "9250lbs"
    },
    "MG 131" => {
      :classification => "Machine Gun",
      :caliber => "13mm"
    },
    "MG 151/20" => {
      :classification => "Cannon",
      :caliber => "20mm"
    },
    "MG 108" => {
      :classification => "Cannon",
      :caliber => "30mm"
    },
    "Browning Mk.II" => {
      :classification => "Machine Gun",
      :caliber => ".303"
    },
    "ShVAK" => {
      :classification => "Cannon",
      :caliber => "20mm"
    },
    "Berezin B-20" => {
      :classification => "Cannon",
      :caliber => "20mm"
    },
  }

weapons_list.each do |name, params_hash|
  p = Weapon.new
  p.name = name
  params_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end
