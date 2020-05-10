VALID_CHOICES = %w(rock paper scissors lizard spock)

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'spock' && second == 'scissors')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

score = [0, 0]

loop do
  choice = ''
  loop do
    prompt("Choose one: (r)ock, (p)aper, (s)cissors, (l)izard, spoc(k)")
    choice = Kernel.gets().chomp()
    
    case choice
    when 'r'    then choice = 'rock'
    when 'p'    then choice = 'paper'
    when 's'    then choice = 'scissors'
    when 'l'    then choice = 'lizard'
    when 'k'    then choice = 'spock'
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample()

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  score[0] += 1 if win?(choice, computer_choice)
  score[1] += 1 if win?(computer_choice, choice)

  if score[0] == 5
    prompt("You won 5 games! You are the grand winner!")
    break
  elsif score[1] == 5
    prompt("The computer won 5 games! The computer is the grand winner!")
    break
  end

  prompt("The score is you: #{score[0]}, computer: #{score[1]}")
  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
