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
		@table = Array.new(4) { |i| Gosu::Image.new("pix/digits/0.png", :tileable => false) }
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




	def button_down (id)
		case id
		when Gosu::KbEscape
			close
		when Gosu::KbLeft
			move_left(@fig)
		when Gosu::KbRight
			move_right(@fig)
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
			@fig_next = MovingFigure.new(5, 0, 1+rand(7))
			@flag = true
		end
		if @gamefield.recount
			if @fig.check_floor and @fig.check_other_figs_down
					@fig.figy+=1
			else
				@newfigure = true
				if @flag
					@flag = false
					$FIELD = @gamefield.fupdate($FIELD, @fig.fcm, @table)
					up_text
					@text_f = true
				end
			end
		end

		if $POINTS.to_i > $BEST.to_i
			File.open('best', "w") { |io| io.write $POINTS.to_s  }
		end
		if gameover
			MenuWindow.new(true).show
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
		@points_text.draw(150, 420, 0)
		x = 210
		y = 10
		@table.each do |pic|
			pic.draw(x, y, 0)
			x+=20
		end
	end

end

class MenuWindow < Gosu::Window
	def initialize (game_over)
		super 200, 200
		self.caption = "Tetris menu"
		@game_over = game_over
		@game_over_text = Gosu::Image.from_text('GAME OVER', 20)
		@start_text = Gosu::Image.from_text('f to start, esc to exit', 20)
		$BEST = IO.read('best')
		@best_text = Gosu::Image.from_text("BEST #{$BEST}", 20)

	end

	def button_down (id)
		case id
		when Gosu::KbF
			TetrisGame.new.show
		when Gosu::KbEscape
			close
		end
	end

	def draw
		if @game_over
			@game_over_text.draw(10, 30, 0)
		end
		@start_text.draw(10, 50, 0)
		@best_text.draw(10, 70, 0)
	end
end

MenuWindow.new(false).show

