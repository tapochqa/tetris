#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore/Field'
require_relative 'gamecore/MovingFigure'


class TetrisGame < Gosu::Window

	def initialize

		@flag, @flag2 = false
		super 300, 400
		self.caption = "Tetris"
		@background = Gosu::Image.new("pix/back.png", :tileable => false)
		@gamefield = Field.new
		@score = 0
		@newfigure = true
		@fig_next = MovingFigure.new(5, 0, 1+rand(7))
		@text_a = 0
		@text_f = false
		$POINTS = 0
		$BEST = IO.read('best')
		$PAUSED = false
		@table = Array.new(4) { Gosu::Image.new("pix/digits/0.png", :tileable => false) }
		@best_table = Array.new(4) { Gosu::Image.new("pix/digits/0.png", :tileable => false) }
		@gamefield.update_best(@best_table)
		up_text
		#variables for methods
		
	end

	def up_text
		@text_a = $POINTS
		@points_text = Gosu::Image.from_text(@text_a.to_s, 20)
	end

	def move_left (fig)
		a = true 
		fig.fcm.each do |c|
			if c[0] == 0 or $FIELD [c[0]-1][c[1]] == 1
				a = false
			end
		end
		if a
			fig.figx -= 1
		end
	end

	def move_right (fig)
		a = true
		fig.fcm.each do |c|
			if c[0] == 9 or $FIELD [c[0]+1][c[1]] == 1
				a = false
			end
		end
		if a 
			fig.figx += 1
		end
	end

	def drop_down
		while @fig.check_floor and @fig.check_other_figs_down
			@fig.figy+=1
			@fig.countfig(@fig.figx, @fig.figy)
		end
	end

	def check_edge(fcm)
		# 1 left
		# 2 right
		# 0 OK
		a = 0
		fcm.each do |c|
			if c[0]<0
				a = 1
			elsif c[0]>9
				a = 2
			end
		end
		a
	end

	def rotate
		a = true
		@morphed_figure = MovingFigure.new(@fig.figx, @fig.figy, @fig.morph(@fig.figtype))
		@morphed_figure.fcm.each do |c|

			if check_edge(@morphed_figure.fcm) == 1
				until check_edge(@morphed_figure.fcm) == 0 do
					@morphed_figure.figx+=1
					@morphed_figure.countfig(@morphed_figure.figx, @morphed_figure.figy)
				end

			elsif check_edge(@morphed_figure.fcm) == 2
				until check_edge(@morphed_figure.fcm) == 0 do 
					@morphed_figure.figx-=1
					@morphed_figure.countfig(@morphed_figure.figx, @morphed_figure.figy)
				end
			end

		end

		@morphed_figure.fcm.each do |c|

			if $FIELD[c[0]][c[1]] == 1
				a = false
			end

		end

		if a
			@fig = @morphed_figure
		end
	end

	def gameover
		a = false
		10.times do |i|
			if $FIELD[i][0] == 1
				a = true
			end
		end
		a
	end

	def switch_pause
		if $PAUSED
			$PAUSED = false
		else
			$PAUSED = true
		end
	end


	def button_down (id)
		case id
		when Gosu::KbEscape
			close
		when Gosu::KbLeft
			if $PAUSED
				move_left(@fig)
			end
		when Gosu::KbRight
			if $PAUSED
				move_right(@fig)
			end
		when Gosu::KbDown
			if $PAUSED
				drop_down
			end
		when Gosu::KbUp
			if $PAUSED
				rotate
			end
		when Gosu::KbSpace
			switch_pause
		end
	end

	def update
		if @newfigure
			@newfigure = false
			@fig = @fig_next
			@fig_next = MovingFigure.new(5, 0, 1+rand(7))
			@flag = true
		end
		if @gamefield.recount
			if @fig.check_floor and @fig.check_other_figs_down
				if $PAUSED
					@fig.figy+=1
				end
			else
				@newfigure = true
				if @flag
					@flag = false
					$FIELD = @gamefield.fupdate($FIELD, @fig.fcm, @table)
				end
			end
		end

		if $POINTS.to_i > $BEST.to_i
			File.open('best', "w") { |io| io.write $POINTS.to_s  }
		end
		if gameover
			TetrisGame.new.show
		end
	end

	def draw
		@background.draw(0, 0, 0)
		@fig_next.draw_mini_image(210, 50)

		10.times do |i|
			20.times do |j|
				if $FIELD[i][j] == 1
					@gamefield.draw(i, j)
				end
			end
		end

		@fig.draw(@fig.figx, @fig.figy)
		x = 210
		y = 10
		@table.each do |pic|
			pic.draw(x, y, 0)
			x+=20
		end
		x = 210
		y = 360
		@best_table.each do |pic|
			pic.draw(x, y, 0)
			x+=20
		end
	end

end

TetrisGame.new.show

