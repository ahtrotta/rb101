require 'pry'

SUITS = %w(hearts diamonds spades clubs)

def prompt(msg)
  puts ">>> #{msg}"
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
  hand.map { |card| card[:value] }.inject(:+)
end

def number_of_aces(hand)
  hand.map { |card| card[:name] }.count('Ace')
end

def busted?(hand)
  hand_value = get_value(hand)
  aces = number_of_aces(hand)
  while hand_value > 21 && aces > 0
    hand_value -= 10
    aces -= 1
  end
  hand_value > 21
end

def game_over(outcome)
  prompt "You #{outcome}! Play again? (y) or (n)"
  answer = gets.chomp.downcase
end

loop do
  deck = initialize_deck.shuffle
  players_hand = deck.pop(2)
  dealers_hand = deck.pop(2)
  visible_dealer_cards = dealers_hand[0][:name]

  loop do
    player_cards = players_hand.map { |card| card[:name] }
    prompt "Your hand: #{player_cards.join(', ')}"
    prompt "Dealer's hand: #{visible_dealer_cards} and unknown card"
    prompt "(h)it or (s)tay?"
    answer = gets.chomp
    break if answer.downcase.start_with?('s')
    drawn_card = deck.pop(1)[0]
    prompt "You drew: #{drawn_card[:name]} of #{drawn_card[:suit]}"
    players_hand << drawn_card
    break if busted?(players_hand)
  end

  if busted?(players_hand)
    player_cards = players_hand.map { |card| card[:name] }
    prompt "Your hand: #{player_cards.join(', ')}"
    break if game_over('lost').start_with?('n')
  else
    prompt "You chose to stay! Dealer's turn."
  end

  loop do
    hand_value = get_value(dealers_hand)
    aces = number_of_aces(dealers_hand)
    while hand_value > 17 && aces > 0
      hand_value -= 10
      aces -= 1
    end
    if hand_value <= 17
      dealer_card = deck.pop(1)[0]
      prompt "Dealer chose to hit. Dealer drew #{dealer_card[:name]}."
      dealers_hand << dealer_card
    else
      prompt "Dealer chose to stay."
      break
    end
  end

  if busted?(dealers_hand)
    break if game_over('won').start_with?('n')
  elsif get_value(dealers_hand) > get_value(players_hand)
    break if game_over('lost').start_with?('n')
  elsif get_value(dealers_hand) < get_value(players_hand)
    break if game_over('won').start_with?('n')
  else
    break if game_over('tied').start_with?('n')
  end

end
