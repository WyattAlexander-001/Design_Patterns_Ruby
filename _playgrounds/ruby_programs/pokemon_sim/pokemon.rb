# pokemon.rb
require 'colorize'

class Pokemon
  attr_reader :name, :type, :max_hp
  attr_reader :base_attack, :base_defense, :base_sp_attack, :base_sp_defense, :base_speed

  attr_accessor :current_hp
  attr_accessor :attack_stage, :defense_stage, :sp_attack_stage, :sp_defense_stage, :speed_stage
  attr_accessor :moves

  # We'll store a color symbol internally, which can be :red, :blue, etc.
  attr_accessor :color_symbol

  def initialize(name:, type:, hp:, attack:, defense:, sp_attack:, sp_defense:, speed:, moves: [])
    @name   = name
    @type   = type
    @max_hp = hp

    @base_attack     = attack
    @base_defense    = defense
    @base_sp_attack  = sp_attack
    @base_sp_defense = sp_defense
    @base_speed      = speed

    @current_hp = hp

    @attack_stage     = 0
    @defense_stage    = 0
    @sp_attack_stage  = 0
    @sp_defense_stage = 0
    @speed_stage      = 0

    @moves = moves

    # Default color is :white unless the Battle class sets it to something else
    @color_symbol = :white
  end

  def alive?
    @current_hp > 0
  end

  def fainted?
    !alive?
  end

  def reset_stats!
    @current_hp       = @max_hp
    @attack_stage     = 0
    @defense_stage    = 0
    @sp_attack_stage  = 0
    @sp_defense_stage = 0
    @speed_stage      = 0
  end

  # Return the Pokemon name in color
  def colored_name
    @name.colorize(@color_symbol)
  end

  # ---------------------------------------
  # Effective Stats (apply stage multipliers)
  # ---------------------------------------
  def effective_attack
    (base_attack * stage_multiplier(@attack_stage)).floor
  end

  def effective_defense
    (base_defense * stage_multiplier(@defense_stage)).floor
  end

  def effective_sp_attack
    (base_sp_attack * stage_multiplier(@sp_attack_stage)).floor
  end

  def effective_sp_defense
    (base_sp_defense * stage_multiplier(@sp_defense_stage)).floor
  end

  def current_speed
    (base_speed * stage_multiplier(@speed_stage)).floor
  end

  private

  def stage_multiplier(stage)
    # clamp to -6..+6 just in case
    stage = stage.clamp(-6, 6)
    if stage >= 0
      (2.0 + stage) / 2.0
    else
      2.0 / (2.0 - stage)
    end
  end
end
