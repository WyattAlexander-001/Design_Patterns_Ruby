# demo.rb

require 'colorize'
require_relative 'move'           # 1) define Move
require_relative 'move_database'  # 2) define MOVES hash
require_relative 'pokemon'        # 3) define Pokemon
require_relative 'battle'         # 4) define Battle

def load_move(key)
  data = MOVES[key]
  Move.new(
    name:      data[:name],
    power:     data[:power],
    move_type: data[:move_type],
    category:  data[:category],
    effect:    data[:effect]
  )
end

# Build Pikachu (Player 1)
pikachu_moves = [
  load_move("thunder_shock"),
  load_move("growl"),
  load_move("iron_tail"),
  load_move("rest")
]

pikachu = Pokemon.new(
  name:       "Pikachu",
  type:       :electric,
  hp:         35,
  attack:     55,
  defense:    30,
  sp_attack:  50,
  sp_defense: 40,
  speed:      90,
  moves:      pikachu_moves
)

# Build Squirtle (Player 2)
squirtle_moves = [
  load_move("tackle"),
  load_move("tail_whip"),
  load_move("water_gun"),
  load_move("withdraw")
]

squirtle = Pokemon.new(
  name:       "Squirtle",
  type:       :water,
  hp:         44,
  attack:     48,
  defense:    65,
  sp_attack:  50,
  sp_defense: 64,
  speed:      43,
  moves:      squirtle_moves
)

# Battle
battle = Battle.new(pikachu, squirtle)
battle.start
