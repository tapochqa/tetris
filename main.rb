#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore'


class TetrisGame < Gosu::Window

	def initialize
		$b1x, $b2x, $b3x, $b4x, $b1y, $b2y, $b3y, $b4y = 0
		@flag, @flag2 = false

		super 200, 500
		self.caption = "Tetris"
		@background = Gosu::Image.new("pix/back.png", :tileable => false)
		
		@gamefield = Field.new
		@score = 0
		@newfigure = true
	end

	def update

		if @newfigure == true
			@newfigure = false
			
			@fig = MovingFigure.new(50, 0)
			@flag = true
			
		end
		if @gamefield.recount
			if @fig.moving
				$figy+=20
			else
				@newfigure = true
				if @flag
					@gamefield.fupdate
				end
			end
		end
	end

	def draw
		@background.draw(0, 0, 0)

		10.times do |i|
			20.times do |j|
				if $FIELD[j+i*10] == 1
					@gamefield.draw(i, j)
				end
			end
		end
		
		@fig.draw($figx, $figy)
		

	end
end

TetrisGame.new.show