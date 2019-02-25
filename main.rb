#!usr/bin/env ruby

require 'gosu'
require_relative 'gamecore/Field'
require_relative 'gamecore/MovingFigure'


class TetrisGame < Gosu::Window

	def initialize

		@flag, @flag_2 = false
		super 300, 400
		self.caption = "Tetris"
		@back_ground = Gosu::Image.new("pix/back.png", :tileable => false)
		@game_field = Field.new
		@new_figure = true
		@fig_next = MovingFigure.new(5, 0, 1+rand(7))
		@text_f = false
		$points = 0
		$best = IO.read('best')
		$paused = false
		@table = Array.new(4) { Gosu::Image.new('pix/digits/0.png', :tileable => false) }
		@best_table = Array.new(4) { Gosu::Image.new('pix/digits/0.png', :tileable => false) }
		@game_field.update_best(@best_table)
		#variables for methods
		
	end

  def move_left (fig)
		a = true 
		fig.fcm.each do |c|
			if c[0] == 0 or $field[c[0]-1][c[1]] == 1
				a = false
			end
		end
		if a
			fig.fig_x -= 1
		end
	end

	def move_right (fig)
		a = true
		fig.fcm.each do |c|
			if c[0] == 9 or $field[c[0]+1][c[1]] == 1
				a = false
			end
		end
		if a
			fig.fig_x += 1
		end
	end

	def drop_down
		while @fig.check_floor and @fig.check_other_figs_down
			@fig.fig_y+=1
			@fig.count_fig(@fig.fig_x, @fig.fig_y)
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
		@morphed_figure = MovingFigure.new(@fig.fig_x, @fig.fig_y, @fig.morph(@fig.fig_type))
		@morphed_figure.fcm.each do |c|

			if check_edge(@morphed_figure.fcm) == 1
				until check_edge(@morphed_figure.fcm) == 0 do
					@morphed_figure.fig_x+=1
					@morphed_figure.count_fig(@morphed_figure.fig_x, @morphed_figure.fig_y)
				end

			elsif check_edge(@morphed_figure.fcm) == 2
				until check_edge(@morphed_figure.fcm) == 0 do 
					@morphed_figure.fig_x-=1
					@morphed_figure.count_fig(@morphed_figure.fig_x, @morphed_figure.fig_y)
				end
			end

		end

		@morphed_figure.fcm.each do |c|

			a = false if $field[c[0]][c[1]] == 1
		end

		@fig = @morphed_figure if a
	end

	def game_over
		a = false
		10.times do |i|
			if $field[i][0] == 1
				a = true
			end
		end
		a
	end

	def switch_pause
		if $paused
			$paused = false
		else
			$paused = true
		end
	end

	def draw_table (x, y, table)
		table.each {|pic|
			pic.draw(x, y, 0)
			x+=20
		}
	end

	def button_down (id)
		case id
		when Gosu::KbEscape
			close
		when Gosu::KbLeft
			if $paused
				move_left(@fig)
			end
		when Gosu::KbRight
			if $paused
				move_right(@fig)
			end
		when Gosu::KbDown
			if $paused
				drop_down
			end
		when Gosu::KbUp
			if $paused
				rotate
			end
		when Gosu::KbSpace
			switch_pause
		end
	end

	def update
		if @new_figure
			@new_figure = false
			@fig = @fig_next
			@fig_next = MovingFigure.new(5, 0, 1+rand(7))
			@flag = true
		end
		if @game_field.recount
			if @fig.check_floor and @fig.check_other_figs_down
				if $paused
					@fig.fig_y+=1
				end
			else
				@new_figure = true
				if @flag
					@flag = false
					$field = @game_field.fupdate($field, @fig.fcm, @table)
				end
			end
		end

		if $points.to_i > $best.to_i
			File.open('best', 'w') { |io| io.write $points.to_s  }
		end
		if game_over
			TetrisGame.new.show
			close
    end
	end

	def draw
		@back_ground.draw(0, 0, 0)
		@fig_next.draw_mini_image(210, 50)

		10.times do |i|
			20.times do |j|
				if $field[i][j] == 1
					@game_field.draw(i, j)
				end
			end
		end
		draw_table(210, 10 , @table)
		draw_table(210, 360, @best_table)
		@fig.draw(@fig.fig_x, @fig.fig_y)
	end

end

TetrisGame.new.show

