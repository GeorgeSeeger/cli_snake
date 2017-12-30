require './lib/game'
require 'json'

settings = JSON.parse(File.open("settings.json").read)

game = Game.new settings
game.game_loop