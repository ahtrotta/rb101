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

def score(brd)
  return 1 if detect_winner(brd) == 'computer'
  return -1 if detect_winner(brd) == 'player'
  return 0
end

def minmax(brd)
  return score(brd) if someone_won?(brd) || board_full?(brd)
end 

board = { 1=>'O', 2=>'X', 3=>' ', 4=>' ', 5=>'X', 6=>' ', 7=>' ', 8=>' ', 9=>' ' }

minmax_values = empty_squares(board).map { |index| [index, 0] }.to_h
empty_squares(board).each do |loc|
  new_board = deep_copy_board(board)
  new_board[loc] = COMPUTER_MARKER
  minmax(new_board, PLAYER_MARKER, loc, minmax_values)
end
binding.pry
p minmax_values
