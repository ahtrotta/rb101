require 'pry'

SUITS = %w(hearts diamonds spades clubs)

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
  while hand_value > 21 && aces > 0
    hand_value -= 10
    aces -= 1
  end
  hand_value
end

def play_again?
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

loop do
  deck = initialize_deck.shuffle
  players_hand = deck.pop(2)
  dealers_hand = deck.pop(2)

  loop do
    system 'clear'
    prompt "Your hand: #{hand_string(players_hand)}. " \
           "Hand value: #{get_value(players_hand)}"
    prompt "Dealer's hand: #{hand_string(dealers_hand, true)}" \
           " and an unknown card."
    prompt "(h)it or (s)tay?"
    answer = gets.chomp
    break if answer.downcase.start_with?('s')
    drawn_card = deck.pop
    prompt "You drew: #{drawn_card[:name]} of #{drawn_card[:suit]}"
    players_hand << drawn_card
    break if get_value(players_hand) > 21
  end

  system 'clear'
  if get_value(players_hand) > 21
    prompt "You busted! Your hand: #{hand_string(players_hand)}"
    break unless play_again?
    next
  else
    prompt "You chose to stay. Dealer's turn."
  end

  loop do
    if get_value(dealers_hand) <= 17
      dealer_card = deck.pop
      prompt "Dealer chose to hit. Dealer drew: " \
             "#{dealer_card[:name]} of #{dealer_card[:suit]}."
      dealers_hand << dealer_card
    elsif get_value(dealers_hand) > 21
      break
    else
      prompt "Dealer chose to stay."
      break
    end
  end

  if get_value(dealers_hand) > 21
    prompt "Dealer busted! You won!"
  elsif get_value(dealers_hand) > get_value(players_hand)
    prompt "You lost!"
  elsif get_value(dealers_hand) < get_value(players_hand)
    prompt "You won!"
  else
    prompt "You tied!"
  end

  prompt "Dealer's hand: #{hand_string(dealers_hand)}. " \
         "Hand value: #{get_value(dealers_hand)}"
  prompt "Your hand: #{hand_string(players_hand)}. " \
         "Hand value: #{get_value(players_hand)}"

  break unless play_again?
end

prompt "Thanks for playing Twenty One!"
