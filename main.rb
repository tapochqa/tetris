#!usr/bin/env ruby

require 'bundler/setup'
require 'gosu'
require_relative 'gamecore/field'
require_relative 'gamecore/moving_figure'
require_relative 'gamecore/table.rb'

$last = 0

class TetrisGame < Gosu::Window

	def initialize
		$init_speed = 12
		$speed = $init_speed #less is faster
    $start_x = 4
    $start_y = 0
		@flag, @flag_2 = false
		super 300, 400
		self.caption = 'Тетрис — нажмите пробел'
		@back_ground = Gosu::Image.new('pix/back.png', :tileable =>  false)
		@drop_sound = Gosu::Sample.new('sound/fall 4.wav')
		@back_ground_sound = Gosu::Song.new("sound/songs/easy #{rand(4)+1}.wav")
		@back_ground_sound.volume = 1
		#@back_ground_sound.play
		@game_field = Field.new
		@new_figure = true
		@fig_next = MovingFigure.new($start_x, $start_y, 1+rand(7))
		@text_f = false
		$points = 0
		$best = IO.read('best')
		$paused = false
		@table = Table.new
		@best_table = Table.new
		@best_table.t_update($best)
		@drop_type = 'soft'
		#variables for methods
		
	end

	def rotate
		a = true
		@morphed_figure = MovingFigure.new(@fig.fig_x, @fig.fig_y, @fig.morph(@fig.fig_type))
		@morphed_figure.fcm.each do |c|

			if @morphed_figure.check_edge == 1
				until @morphed_figure.check_edge == 0 do
					@morphed_figure.fig_x+=1
					@morphed_figure.count_fig(@morphed_figure.fig_x, @morphed_figure.fig_y)
				end

			elsif @morphed_figure.check_edge == 2
				until @morphed_figure.check_edge == 0 do
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
			@back_ground_sound.pause
		else
			$paused = true
			@back_ground_sound.play(looping = true)
		end
	end



	def button_down (id)
		case id
      when Gosu::KbEscape
		  	close
      when Gosu::KbLeft
        @fig.move_left if $paused
      when Gosu::GpLeft
        @fig.move_left if $paused
	  	when Gosu::KbRight
        @fig.move_right if $paused
      when Gosu::GpRight
        @fig.move_right if $paused
      when Gosu::KbDown
        @fig.drop_down if $paused
				@drop_type = false
      when Gosu::GpButton0
        @fig.drop_down if $paused
      when Gosu::KbUp
        rotate if $paused
      when Gosu::GpButton2
        rotate if $paused
      when Gosu::KbSpace
        switch_pause
      when Gosu::GpButton6
        switch_pause
      else
        # type code here
    end
	end

	def update
		if @new_figure
			@new_figure = false
			@fig = @fig_next
			@fig_next = MovingFigure.new($start_x, $start_y, 1+rand(7))
			@flag = true
		end
		if @fig.check_floor and @fig.check_other_figs_down and @game_field.recount
			if $paused
				@fig.fig_y+=1
			end
		end
		unless @fig.check_floor and @fig.check_other_figs_down
			@fig.drop_sound_play(@drop_type)
			@new_figure = true
			@drop_type = true
			if @flag
				@flag = false
				$field = @game_field.fupdate($field, @fig.fcm)
				@table.t_update($points)
				$speed = [1, ($init_speed - ($points / 10).to_i)].max
				puts $speed
			end
		end

		if $points.to_i > $best.to_i
			File.open('best', 'w') { |io| io.write $points.to_s  }
		end
		if game_over
			@back_ground_sound.pause
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
		@table.draw_table(210, 10)
		@best_table.draw_table(210, 360)
		@fig.draw(@fig.fig_x, @fig.fig_y)
	end

end

class Menu < Gosu::Window

  def initialize
  	super 100, 100
		@back_ground = Gosu::Image.new('pix/menu_back.png')
    @last = Table.new.t_update($last)
    @best = Table.new.t_update($best)
	end

  def update
    #
  end

  def draw
    @back_ground.draw(0, 0, 0)
  end

end

TetrisGame.new.show
#Menu.new.show
