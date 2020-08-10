require 'open-uri'
class GamesController < ApplicationController
    def new
      @alphabet = ("a".."z").to_a
      @letters = [];
      loop do
        @letters.push(@alphabet[rand(0...@alphabet.length)].upcase)
        break if @letters.length == 10;
      end
    end

    def score
      @word = params["word"].upcase
      @grid = params["letters"]
      filepath = open("https://wagon-dictionary.herokuapp.com/#{@word}")
      @hash_result = JSON.parse(filepath.read)
      @included = included?(@word, @grid)
    end

    private
    def included?(guess, grid)
      guess.chars.all?{ |letter| guess.count(letter) <= grid.count(letter)}   
    end
end
