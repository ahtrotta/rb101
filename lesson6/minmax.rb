=begin

1. iterate through empty spaces
  - place marker on empty spot

=end

require 'pry'

FIRST_MOVE = 'choose'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'computer'
    end
  end
  nil
end

def deep_copy_board(brd)
  brd.map { |k, v| [k.dup, v.dup] }.to_h
end

def switch_player(marker)
  marker == COMPUTER_MARKER ? PLAYER_MARKER : COMPUTER_MARKER
end

def score_board(brd)
  return 1 if detect_winner(brd) == 'computer'
  return -1 if detect_winner(brd) == 'player'
  return 0
end

def minmax(brd, marker)
  return score_board(brd) if someone_won?(brd) || board_full?(brd)

  scores = []
  moves = []

  brd_copy = deep_copy_board(brd)
  empty_squares(brd_copy).each do |inner_loc|
    brd_copy[inner_loc] = marker
    scores << minmax(brd_copy, switch_player(marker))
    moves << inner_loc
  end
end 

board = { 1=>'X', 2=>' ', 3=>'O', 4=>'O', 5=>' ', 6=>' ', 7=>'O', 8=>'X', 9=>'X' }

score = empty_squares(board).map { |loc| [loc, 0] }.to_h
board_clone = deep_copy_board(board)

empty_squares(board_clone).each do |loc|
  board_clone[loc] = COMPUTER_MARKER
  score[loc] = minmax(board_clone, PLAYER_MARKER)
end

p score
