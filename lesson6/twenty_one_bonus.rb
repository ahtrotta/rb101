require 'pry'

SUITS = %w(hearts diamonds spades clubs)
MAX_VALUE = 21
DEALER_LIMIT = 17

def prompt(msg)
  puts ">>  #{msg}"
end

def get_card_info(card_index)
  case card_index
  when 1      then ['Ace', 11]
  when 2..10  then [card_index.to_s, card_index]
  when 11     then ['Jack', 10]
  when 12     then ['Queen', 10]
  when 13     then ['King', 10]
  end
end

def initialize_deck
  deck = []
  SUITS.each do |suit|
    (1..13).each do |index|
      card = { suit: suit }
      card[:name], card[:value] = get_card_info(index)
      deck << card
    end
  end
  deck
end

def get_value(hand)
  hand_value = hand.map { |card| card[:value] }.inject(:+)
  aces = hand.map { |card| card[:name] }.count('Ace')
  while hand_value > MAX_VALUE && aces > 0
    hand_value -= 10
    aces -= 1
  end
  hand_value
end

def game_end(score, outcome)
  case outcome
  when :player_busted
    prompt "You busted!"
    score[:dealer] += 1
  when :dealer_busted
    prompt "Dealer busted!"
    score[:player] += 1
  when :player_won
    prompt "You won!"
    score[:player] += 1
  when :dealer_won
    prompt "Dealer won!"
    score[:dealer] += 1
  when :tied
    prompt "You tied!"
  end
  prompt "Player: #{score[:player]}, Dealer: #{score[:dealer]}"
end

def play_again?(score)
  return false if score.values.any?(5)

  loop do
    prompt "Play again? (y) or (n)"
    answer = gets.chomp.downcase
    next unless answer == 'y' || answer == 'n'
    break answer == 'y'
  end
end

def hand_string(hand, hidden=false)
  if hidden
    hand[1..-1].map { |card| card[:name] }.join(', ')
  else
    hand.map { |card| card[:name] }.join(', ')
  end
end

def update_hand_value(current_value, new_card)
  new_value = current_value + new_card[:value]
  new_value -= 10 if new_value > MAX_VALUE && new_card[:name] == 'Ace'
  new_value
end

score = { player: 0, dealer: 0 }
loop do
  deck = initialize_deck.shuffle
  players_hand = deck.pop(2)
  dealers_hand = deck.pop(2)
  player_hand_value = get_value(players_hand)
  dealer_hand_value = get_value(dealers_hand)

  loop do
    system 'clear'
    prompt "Your hand: #{hand_string(players_hand)}. " \
           "Hand value: #{player_hand_value}"
    prompt "Dealer's hand: #{hand_string(dealers_hand, true)}" \
           " and an unknown card."
    prompt "(h)it or (s)tay?"
    answer = gets.chomp
    break if answer.downcase.start_with?('s')
    drawn_card = deck.pop
    prompt "You drew: #{drawn_card[:name]} of #{drawn_card[:suit]}"
    players_hand << drawn_card
    player_hand_value = update_hand_value(player_hand_value, drawn_card)
    break if player_hand_value > MAX_VALUE
  end

  system 'clear'
  if player_hand_value > MAX_VALUE
    prompt "Your hand: #{hand_string(players_hand)}. " \
           "Hand value: #{player_hand_value}"
    game_end(score, :player_busted)
    break unless play_again?(score)
    next
  else
    prompt "You chose to stay. Dealer's turn."
  end

  loop do
    if dealer_hand_value <= DEALER_LIMIT
      dealer_card = deck.pop
      prompt "Dealer chose to hit. Dealer drew: " \
             "#{dealer_card[:name]} of #{dealer_card[:suit]}."
      dealers_hand << dealer_card
      dealer_hand_value = update_hand_value(dealer_hand_value, dealer_card)
    elsif dealer_hand_value > MAX_VALUE
      break
    else
      prompt "Dealer chose to stay."
      break
    end
  end

  prompt "Your hand: #{hand_string(players_hand)}. " \
         "Hand value: #{player_hand_value}"
  prompt "Dealer's hand: #{hand_string(dealers_hand)}. " \
         "Hand value: #{dealer_hand_value}"

  if dealer_hand_value > MAX_VALUE
    game_end(score, :dealer_busted)
    break unless play_again?(score)
  elsif dealer_hand_value > player_hand_value
    game_end(score, :dealer_won)
    break unless play_again?(score)
  elsif dealer_hand_value < player_hand_value
    game_end(score, :player_won)
    break unless play_again?(score)
  else
    game_end(score, :tied)
    break unless play_again?(score)
  end
end

if score[:player] == 5
  prompt "You won 5 games! You are the champion!"
elsif score[:dealer] == 5
  prompt "The dealer won 5 games! The dealer is the champion!"
end

prompt "Thanks for playing Twenty One!"
