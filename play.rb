class Hangman

    def initialize
        @word = words.sample
        @lives = 7
        @word_teaser = ""

        @word.first.size.times do
            @word_teaser += "_ "
        end
    end

    def  words
        [
            ["cricket", "A game played by gentlemen"],
            ["jogging", "pavement pounding"],
            ["swimming", "No human is born able to"],
            ["cycling", "the fastest unregulated transportation"],
            ["spam", "the meat of WW2"],
        ]
    end

    def print_teaser last_guess = nil
        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end

    def update_teaser last_guess
        new_teaser = @word_teaser.split

        new_teaser.each_with_index do |letter, index|
            #replace blank values with guessed letters if matches letters in word
            if letter == '_' && @word.first[index] == last_guess
                new_teaser[index] = last_guess
            end 
        end

        @word_teaser = new_teaser.join(' ')
    end

    def make_guess
        if @lives > 0
            puts "Enter a letter"
            guess = gets.chomp

            good_guess = @word.first.include? guess

            if guess == "exit"
                puts "thank you for playing"

            #if guess is longer than one letter
            elsif guess.length > 1
                puts "Only guess 1 letter at a time"
                    make_guess

            elsif good_guess
                puts "you are correct."

                print_teaser guess

                if @word.first == @word_teaser.split.join
                    puts "Congratulations.. You have won this round."
                else
                    make_guess
                end

            else    
                @lives -= 1
                puts "Sorry... you have #{ @lives} lives left. Try again."
                make_guess
            
            end
        else
            puts "Game over."
        end
    end

    def begin

        puts "New game started... your word is #{ @word.first.size } characters long"
        puts "To quit game type 'exit' at any time."
        print_teaser
        puts "Clue: #{ @word.last }"

        make_guess
    end
end

game = Hangman.new
game.begin