#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore/Field'
require_relative 'gamecore/MovingFigure'


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
		@text_a = 0
		@text_f = false
		#up_text
	end



	def up_text
		@text_a += 1
		@debug_text = Gosu::Image.from_text(@text_a.to_s, 20)
	end
	def update

		if @newfigure
			@newfigure = false
			@fig = MovingFigure.new(5, 0)
			@flag = true
			
		end
		if @gamefield.recount
			if @fig.moving
				$figy+=1
			else
				@newfigure = true
				if @flag
					@flag = false
					$FIELD = @gamefield.fupdate($FIELD)
					@text_f = true
				end
			end
		end
	end



	def draw
		@background.draw(0, 0, 0)

		20.times do |i|
			10.times do |j|
				if $FIELD[j+i*10] == 1
					@gamefield.draw(i, j)
					if @text_f
						up_text
					end
				end
			end
		end
		if @text_f
			@text_f = false
		end

		@fig.draw($figx, $figy)
		#@debug_text.draw(0, 100, 0)

	end

end

TetrisGame.new.show