require 'pry'

FIRST_MOVE = 'choose'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delim=', ', word='or')
  if arr.size > 1
    arr[-1] = "#{word} #{arr[-1]}"
    if arr.size > 2
      arr.join(delim)
    else
      arr.join(' ')
    end
  elsif arr.size == 1
    arr[0].to_s
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "1    |2    |3"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "4    |5    |6"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]} "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "7    |8    |9"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]} "
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def finder(brd, mode)
  marker = nil
  if mode == :defense
    marker = PLAYER_MARKER
  elsif mode == :offense
    marker = COMPUTER_MARKER
  end

  WINNING_LINES.each do |line|
    current_line = line.map { |num| brd[num] }
    if current_line.count(marker)== 2 &&
       current_line.count(INITIAL_MARKER) == 1
      return line[current_line.index(INITIAL_MARKER)]
    end
  end
  nil
end

def computer_places_piece(brd)
  square = nil
  if finder(brd, :offense)
    square = finder(brd, :offense)
  elsif finder(brd, :defense)
    square = finder(brd, :defense)
  elsif brd[5] == INITIAL_MARKER
    square = 5
  else
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
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

def place_piece(brd, player)
  player_places_piece(brd) if player == 'player'
  computer_places_piece(brd) if player == 'computer'
end

score = { computer: 0, player: 0 }
loop do
  board = initialize_board

  first = FIRST_MOVE
  if first == 'choose'
    loop do
      prompt 'Who should go first? (p)layer or (c)omputer?'
      response = gets.chomp

      if response.start_with?('p')
        first = 'player'
        break
      elsif response.start_with?('c')
        first = 'computer'
        break
      end

      prompt 'Please try again.'
    end
  end

  current_player = first
  loop do
#    display_board(board)
#    if first == 'player'
#      player_places_piece(board)
#      display_board(board)
#      break if someone_won?(board) || board_full?(board)
#      computer_places_piece(board)
#    elsif first == 'computer'
#      computer_places_piece(board)
#      display_board(board)
#      break if someone_won?(board) || board_full?(board)
#      player_places_piece(board)
#    end
#    display_board(board)
    display_board(board)
    place_piece(board, current_player)
    current_player = current_player == 'player' ? 'computer' : 'player'
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    score[detect_winner(board).to_sym] += 1
    prompt "#{detect_winner(board).capitalize} won!"
    prompt "The score is computer: #{score[:computer]}, player: #{score[:player]}."
  else
    prompt "It's a tie!"
  end
  
  if score.values.include?(5)
    prompt "#{detect_winner(board).capitalize} is the grand champion!"
    break
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
