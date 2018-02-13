class GamesController < ApplicationController
  def new
    @start_time = Time.now
    letter_array = ("a".."z").to_a
    word_length = rand(5..10) # longest word in EN = Pneumonoultramicroscopicsilicovolcanoconiosis (45 letters)
    @letters = letter_array.sample(word_length)
  end

  def score
    @score_time = Time.now - Time.parse(params[:start_time])
    @user_input = params[:input]
    letters_string = params[:letters]
    @letters = letters_string.split("")
    test_included = word_included?(@user_input, @letters)
    test_english = word_english?(@user_input)
    if test_included && test_english
      @result = "Correct!"
    elsif test_included && !test_english
      @result = "Not an english word!"
    elsif !test_included && test_english
      @result = "You can't build this word with the provided characters!"
    else
      @result = "Neither can you create this word with the given characters, nor is this an english word..."
    end
  end

  def word_included?(user_input, letters)
    user_input.chars.each do |letter|
      match = letters.include? letter
      if !match
        return match
        break
      else
        letters -= letter.split
      end
    end
    return true
  end

  def word_english?(user_input)
    url = "https://wagon-dictionary.herokuapp.com/#{user_input}"
    response = open(url).read
    parsed_response = JSON.parse(response)
    return parsed_response["found"]
  end
end
