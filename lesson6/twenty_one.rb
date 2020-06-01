require 'pry'

SUITS = %w(hearts diamonds spades clubs)

def prompt(msg)
  puts ">>> #{msg}"
end

def get_card_info(card_index)
  case card_index
  when 1      then ['Ace', [1, 11]]
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

def deal_hand(deck)
  deck.pop(2)
end

deck = initialize_deck.shuffle
players_hand = deal_hand(deck)
dealers_hand = deal_hand(deck)

loop do
  player_cards = players_hand.map { |card| card[:name] }
  visible_dealer_card = dealers_hand[0][:name]
  prompt "Your hand: #{player_cards.join(', ')}"
  prompt "Dealer's hand: #{visible_dealer_card} and unknown card"
  prompt "(h)it or (s)tay?"
  answer = gets.chomp
  break if answer.downcase.start_with?('s')
end
