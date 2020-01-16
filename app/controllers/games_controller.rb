require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(12) { ('A'..'Z').to_a.sample }
  end

  def score
    @grid = params[:grid]
    @word = params[:word].upcase

    if @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }
      response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
      json = JSON.parse(response.read)
      if json["found"] == true
        @result = "well done '#{@word.downcase}' is correct"
      else
        @result = "Sorry '#{@word.downcase}' is not an english word"
      end
    else
      @result = "Sorry '#{@word.downcase}' is not in the letters"
    end
  end
end
