def deep_copy_board(brd)
  brd.map { |k, v| [k.dup, v.dup] }.to_h
end

def minmax(brd, player_marker, val=0)
  new_brd = deep_copy_board(brd)
  new_brd.each do |brd_loc, marker|
    if marker == INITIAL_MARKER
      brd_copy = deep_copy_board(brd)
      brd_copy[brd_loc] = player_marker

      if board_full?(brd_copy)
        if someone_won?(brd_copy)
          return 1 if detect_winner(brd_copy) == 'computer'
          return -1 if detect_winner(brd_copy) == 'player'
        else
          return 0
        end
      end

      player_marker = if player_marker == PLAYER_MARKER
                        COMPUTER_MARKER
                      else
                        PLAYER_MARKER
                      end

      minmax(brd_copy, player_marker, val)
    end
  end
end


