class HangmanDrawing

    def initialize
        @hangman = ['''




========''','''

  +---+
      |
      |
      |
      |
      |
=========''','''

  +---+
  |   |
  O   |
      |
      |
      |
=========''','''

  +---+
  |   |
  O   |
  |   |
      |
      |
=========''','''

  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========''','''

  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
=========''']

    end

    def draw_hangman(chances)

        case chances
            when 5
                puts(@hangman[0])
            when 4
                puts @hangman[1]
            when 3
                puts(@hangman[2])
            when 2
                puts @hangman[3]
            when 1
                puts(@hangman[4])
            when 0
                puts(@hangman[5])
                puts("HANGED \n GAME OVER")

            else puts("YOU LOST..")
        end

    end

end
