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
  card_names = hand.map { |card| card[:name] }
  card_names.count('Ace')
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

deck = initialize_deck.shuffle
players_hand = deck.pop(2)
dealers_hand = deck.pop(2)

loop do
  player_cards = players_hand.map { |card| card[:name] }
  visible_dealer_card = dealers_hand[0][:name]

  loop do
    prompt "Your hand: #{player_cards.join(', ')}"
    prompt "Dealer's hand: #{visible_dealer_card} and unknown card"
    prompt "(h)it or (s)tay?"
    answer = gets.chomp
    break if answer.downcase.start_with?('s')
    drawn_card = deck.pop(1)[0]
    prompt "You drew: #{drawn_card[:name]} of #{drawn_card[:suit]}"
    break if busted?(players_hand)
  end

  if busted?(players_hand)
    prompt "You lost! Play again? (y) or (n)"
    response = gets.chomp
    break if response.downcase.start_with?('n')
  else
    prompt "You chose to stay! Dealer's turn."
  end

  loop do
    hand_value = get_value(dealers_hand)
    if hand_value > 21
    break if hand_value >= 17
  end

end
