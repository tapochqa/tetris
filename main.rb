#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore/Field'
require_relative 'gamecore/MovingFigure'


class TetrisGame < Gosu::Window

	def initialize
		@flag, @flag2 = false
		super 200, 500
		self.caption = "Tetris"
		@background = Gosu::Image.new("pix/back.png", :tileable => false)
		@gamefield = Field.new
		@score = 0
		@newfigure = true
		@fig_next = MovingFigure.new(5, 0, 1+rand(6))
		@text_a = 0
		@text_f = false
		#up_text
	end

	def up_text
		@text_a += 1
		@debug_text = Gosu::Image.from_text(@text_a.to_s, 20)
	end

	def move_left 
		a = true 
		@fig.fcm.each do |c|
			if c[0] == 0 or $FIELD [c[0]-1][c[1]] == 1
				a = false
			end
		end
		if a
			$figx -= 1
		end
	end

	def move_right
		a = true
		@fig.fcm.each do |c|
			if c[0] == 9 or $FIELD [c[0]+1][c[1]] == 1
				a = false
			end
		end
		if a 
			$figx += 1
		end
	end


	def drop_down
		while @fig.check_floor and @fig.check_other_figs_down
			$figy+=1
			@fig.countfig($figx, $figy)
		end
	end

	def rotate
		a = true
		@morphed_figure = MovingFigure.new($figx, $figy, @fig.morph(@fig.figtype))
		@morphed_figure.fcm.each do |c|
			if $FIELD [c[0]][c[1]] == 1
				a = false
			end
		end
		if a
			@fig = @morphed_figure
		end
	end


	def button_down (id)
		case id
		when Gosu::KbEscape
			close
		when Gosu::KbLeft
			move_left
		when Gosu::KbRight
			move_right
		when Gosu::KbDown
			drop_down
		when Gosu::KbUp
			rotate
		end
	end

	def update
		if @newfigure
			@newfigure = false
			@fig = @fig_next
			@fig_next = MovingFigure.new(5, 0, 1+rand(6))
			@flag = true
		end
		if @gamefield.recount
			if @fig.check_floor and @fig.check_other_figs_down
					$figy+=1
			else
				@newfigure = true
				if @flag
					@flag = false
					$FIELD = @gamefield.fupdate($FIELD, @fig.fcm)
					@text_f = true
				end
			end
		end
	end

	def draw
		@background.draw(0, 0, 0)
		@fig_next.draw_mini_image(50, 450)

		10.times do |i|
			20.times do |j|
				if $FIELD[i][j] == 1
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