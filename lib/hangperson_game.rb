class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word, :guesses, :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @current_word_with_guesses = '-' * word.length
  end

  def guess(letter)

    if letter == '' or letter == nil or letter.match(/[^a-zA-Z]/)
      raise ArgumentError, "Invalid"
    end
    letter = letter.downcase


    if @guesses.match?(letter) or @wrong_guesses.match?(letter)
      return false
    end


    if @word.match?(letter)
      @guesses += letter
      (0 ... @word.length).each {|index| if @word[index] == letter
           @current_word_with_guesses[index] = letter
        end}
    else
      @wrong_guesses += letter
    end
    return true
  end

  def word_with_guesses
    return @current_word_with_guesses
  end

  def check_win_or_lose
    if not @current_word_with_guesses.match?('-')
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
