#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore'

class TetrisGame < Gosu::Window

	def initialize
		$figx = []
		$figy = []
		$cof = 0
		@fig = []
		super 200, 500
		self.caption = "Tetris"
		@background = Gosu::Image.new("pix/back.png", :tileable => false)
		
		@gamefield = Field.new
		@score = 0
		@newfigure = true
	end

	def update

		if @newfigure == true
			@fig.push(Figure.new(0, 0))
			$cof+=1
			@debug_cof = Gosu::Image.from_text $cof.to_s, 20
			@newfigure = false
		end
		@debug_fig = Gosu::Image.from_text @fig.size.to_s, 20
		if @gamefield.recount
			if @fig[@fig.size-1].moving
				$figy[$cof-1]+=10
				
			else
				@newfigure = true
			end
		end
	end

	def draw
		@background.draw(0, 0, 0)
		@debug_cof.draw(0, 0, 0)
		@debug_fig.draw(0, 30, 0)
		$cof.times do |k|
			@fig[k-1].draw($figx[k-1], $figy[k-1])
		end
	end
end

TetrisGame.new.show