require_relative "HangmanDrawing"

def import_words_file(file)
	File.open(file, "r") do |f|
		words = []
		f.each_line do |line|
			words << line.chomp.downcase
		end
		return words
	end

end


class Hangman

	def initialize(words)
		@wordslist = words
		@already_guessed = ""
		@chances = 5
		@secret_word = ""
		@missing_word = ""
		@hangman_pic = HangmanDrawing.new

	end


	def get_random_word
		wordindex = rand(0...(@wordslist.length)-1)
		@wordslist[wordindex]
	end


	def get_guess
		while TRUE do
			guess = gets.chomp


			if guess.length!=1
				puts("Please enter a single letter")

			elsif @already_guessed.include? "#{guess}"
					 puts("Already guessed, Pick another letter")

			elsif  !("abcdefghijklmnopqrstuvwxyz".include? "#{guess}")
					  puts("Already guessed, Pick another letter")

			else return guess

			end
		end
	end


	def update_chance
		if @chances > 0
			@chances -= 1
		end

		if @chances == 0
			system("clear")
			@hangman_pic.draw_hangman(@chances)
			puts("You lost \n NO Chances left..")
			puts("Your word is: #{@secret_word}")
			play_again
		end
	end


	def find_occurrence_and_update(character)

		indexes = (0 ... @secret_word.length).find_all { |i| @secret_word[i,1] == "#{character}"}

		indexes.each do |i|
			@missing_word[i] = character

		end

	end


	def vowel_hint
		vowels = %w[a e i o u]
		vowels_count = 0
		vowels.each do |i|
			if @secret_word.include?"#{i}"
				vowels_count += 1
			end
		end
		vowels_count
	end

	def game_board

		puts("lets play hangman...")
		@secret_word = get_random_word.chomp

		if vowel_hint
			puts("Hint: Different vowels present->#{vowel_hint}")
		else puts("Hint: No vowels present in word")
		end

		@missing_word = "#" * @secret_word.length
		# puts(@secret_word)
		# puts(@secret_word.length)

		while TRUE do
			@hangman_pic.draw_hangman(@chances)
			puts(@missing_word)
			puts("Chances left: #{@chances} ")
			puts("Enter any character...")
			guess_character = get_guess
			@already_guessed += "#{guess_character}"

			if @secret_word.include? "#{guess_character}"
				puts("Congo you guessed correct letter...")
				find_occurrence_and_update(guess_character)

			else
				puts("OOPS!! you guessed it wrong...")
				update_chance
			end

			unless @missing_word.include? "#"
				puts("Congrats!! You Won")
				play_again
			end

			system("clear")
		end

	end


	def play_again
		puts("Wanna play again..? \n yes/no")
		choice = gets.chomp
		if choice == 'yes' or choice == 'y'
			system("clear")
			new_player = Hangman.new(@wordslist)
			new_player.game_board
		else
			puts("Thanks for playing...")
			exit
		end
	end

end


words_list = import_words_file("wordlist.txt")
# puts words_list

player = Hangman.new(words_list)
player.game_board
