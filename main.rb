#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore'

class TetrisGame < Gosu::Window

	def initialize
		super 200, 500
		self.caption = "Tetris"
		@background = Gosu::Image.new("pix/back.png", :tileable => false)
		@gamefield = Field.new
		@score = 0
		@newfigure = true
	end

	def update

		if @newfigure == true
			@fig = Figure.new(0, 0)
			@newfigure = false
		end
		
		if @gamefield.recount
			if @fig.moving
				$figy+=10
			end
		end
	end

	def draw
		@background.draw(0, 0, 0)
		@fig.draw($figx, $figy)
	end
end

TetrisGame.new.show