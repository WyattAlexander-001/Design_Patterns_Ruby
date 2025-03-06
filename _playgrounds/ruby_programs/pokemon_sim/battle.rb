# battle.rb
require 'colorize'
require_relative 'pokemon'
require_relative 'move'

class Battle
  def initialize(pokemon1, pokemon2)
    @pokemon1 = pokemon1
    @pokemon2 = pokemon2
    # Assign color: p1 is red, p2 is blue
    @pokemon1.color_symbol = :red
    @pokemon2.color_symbol = :blue

    @turn_count = 0
  end

  def start
    # Print a fancy banner for the start
    puts "======================================".yellow
    puts " A Battle Begins! ".upcase.center(38).yellow
    puts "======================================".yellow
    puts

    # Print a quick label
    puts "P1: #{p1.colored_name} vs P2: #{p2.colored_name}"
    puts

    # Show each Pokémon’s moves
    puts "#{p1.colored_name} Moves:"
    p1.moves.each_with_index do |mv, i|
      puts "  (#{i+1}) #{mv.name}"
    end
    puts

    puts "#{p2.colored_name} Moves:"
    p2.moves.each_with_index do |mv, i|
      puts "  (#{i+1}) #{mv.name}"
    end
    puts

    # Initial statuses
    show_status(p1)
    show_status(p2)

    # Main loop
    while p1.alive? && p2.alive?
      @turn_count += 1
      puts "\n--- Turn #{@turn_count} ---".yellow

      # Sort speed
      first, second = sort_by_speed(p1, p2)

      # Move 1
      do_move(first, second) if first.alive? && second.alive?
      # Show BOTH statuses
      if first.alive? && second.alive?
        show_status(first)
        show_status(second)
      end

      # Move 2
      if second.alive? && first.alive?
        do_move(second, first)
        # Show BOTH statuses
        show_status(first) if first.alive?
        show_status(second) if second.alive?
      end
    end

    declare_winner
  end

  private

  def p1
    @pokemon1
  end

  def p2
    @pokemon2
  end

  # A single move usage
  def do_move(attacker, defender)
    chosen_move = attacker.moves.sample
    puts "\n#{attacker.colored_name} is about to use: #{chosen_move.name.colorize(:light_magenta)}"
    chosen_move.use(attacker, defender)
  end

  # Compare speeds
  def sort_by_speed(a, b)
    s1 = a.current_speed
    s2 = b.current_speed
    return [a, b] if s1 > s2
    return [b, a] if s2 > s1
    # tie
    rand(2).zero? ? [a, b] : [b, a]
  end

  def show_status(pokemon)
    # For a bit more spacing
    puts
    puts "Status of #{pokemon.colored_name} (HP/Stages):"
    puts "  HP:        #{pokemon.current_hp}/#{pokemon.max_hp}"
    puts "  Attack:    Stage=#{pokemon.attack_stage}, Effective=#{pokemon.effective_attack}"
    puts "  Defense:   Stage=#{pokemon.defense_stage}, Effective=#{pokemon.effective_defense}"
    puts "  Sp.Atk:    Stage=#{pokemon.sp_attack_stage}, Effective=#{pokemon.effective_sp_attack}"
    puts "  Sp.Def:    Stage=#{pokemon.sp_defense_stage}, Effective=#{pokemon.effective_sp_defense}"
    puts "  Speed:     Stage=#{pokemon.speed_stage}, Effective=#{pokemon.current_speed}"
    puts
  end

  def declare_winner
    if p1.alive? && !p2.alive?
      puts "\n#{p2.colored_name} fainted! #{p1.colored_name} wins!".colorize(:light_green)
    elsif p2.alive? && !p1.alive?
      puts "\n#{p1.colored_name} fainted! #{p2.colored_name} wins!".colorize(:light_green)
    else
      puts "\nBoth Pokémon fainted! It's a draw!".colorize(:light_green)
    end
  end
end
