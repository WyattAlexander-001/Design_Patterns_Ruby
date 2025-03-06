# move_database.rb

MOVES = {
  "thunder_shock" => {
    name: "Thunder Shock",
    power: 40,
    move_type: :attack,
    category: :special
  },
  "growl" => {
    name: "Growl",
    power: 1,
    move_type: :status,
    effect: :lower_attack
  },
  "iron_tail" => {
    name: "Iron Tail",
    power: 100,
    move_type: :attack,
    category: :physical
  },
  "rest" => {
    name: "Rest",
    power: 0,
    move_type: :heal
  },
  "tackle" => {
    name: "Tackle",
    power: 40,
    move_type: :attack,
    category: :physical
  },
  "tail_whip" => {
    name: "Tail Whip",
    power: 1,
    move_type: :status,
    effect: :lower_defense
  },
  "water_gun" => {
    name: "Water Gun",
    power: 40,
    move_type: :attack,
    category: :special
  },
  "withdraw" => {
    name: "Withdraw",
    power: 1,
    move_type: :status,
    effect: :raise_defense
  }
}
