# move.rb
require 'colorize'

class Move
  attr_reader :name, :power, :move_type, :category, :effect

  def initialize(name:, power:, move_type:, category: nil, effect: nil)
    @name      = name # E.g Thunder Shock
    @power     = power # E.g 40
    @move_type = move_type  # :attack, :status, :heal
    @category  = category   # :physical or :special
    @effect    = effect     # e.g. :lower_attack, :raise_defense, etc.
  end

  def use(attacker, defender)
    case @move_type 
    when :attack
      apply_attack(attacker, defender)
    when :status
      apply_status_effect(attacker, defender)
    when :heal
      apply_heal(attacker)
    else
      puts "#{attacker.name} tried to use #{@name}, but it's not implemented!"
    end
  end

  private

  def apply_attack(attacker, defender)
    atk = (@category == :special) ? attacker.effective_sp_attack : attacker.effective_attack
    dfn = (@category == :special) ? defender.effective_sp_defense : defender.effective_defense

    damage = (@power * (atk.to_f / [dfn, 1].max)).floor
    damage = 1 if damage < 1

    old_hp = defender.current_hp
    defender.current_hp = [defender.current_hp - damage, 0].max

    puts "#{attacker.colored_name} used #{@name.colorize(:light_cyan)}!"
    puts "  Damage Dealt: #{damage.to_s.colorize(:red)} (#{old_hp} → #{defender.current_hp} HP)"
    if defender.fainted?
      puts "  #{defender.colored_name} fainted!"
    end
  end

  def apply_status_effect(attacker, defender)
    puts "#{attacker.colored_name} used #{@name.colorize(:light_cyan)}!"

    case @effect
    when :lower_attack
      old_stage = defender.attack_stage
      new_stage = old_stage - @power
      defender.attack_stage = clamp_stage(new_stage)
      puts "  #{defender.colored_name}'s Attack stage: #{old_stage} → #{defender.attack_stage}"

    when :lower_defense
      old_stage = defender.defense_stage
      new_stage = old_stage - @power
      defender.defense_stage = clamp_stage(new_stage)
      puts "  #{defender.colored_name}'s Defense stage: #{old_stage} → #{defender.defense_stage}"

    when :raise_defense
      old_stage = attacker.defense_stage
      new_stage = old_stage + @power
      attacker.defense_stage = clamp_stage(new_stage)
      puts "  #{attacker.colored_name}'s Defense stage: #{old_stage} → #{attacker.defense_stage}"

    else
      puts "  No special effect is defined for #{@name}!"
    end
  end

  def apply_heal(pokemon)
    old_hp = pokemon.current_hp
    pokemon.current_hp = pokemon.max_hp

    puts "#{pokemon.colored_name} used #{@name.colorize(:light_cyan)}!"
    puts "  HP Restored: (#{old_hp} → #{pokemon.current_hp})"
  end

  def clamp_stage(stage)
    stage.clamp(-6, 6)
  end
end
