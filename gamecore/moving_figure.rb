class MovingFigure

	def f_to_f (fig_type)
		
		f = Array.new {[]}
		c = Array.new(2, 0)

		IO.foreach("gamecore/#{fig_type}") {|line|
			line.split('').each {|symbol|
				if symbol == '1'
					f.push([c[0], c[1]])
				end
				c[0]+=1
			}
			c[0]=0
			c[1]+=1
		}
		f
	end


	def count_fig (x, y)
		# @fcm is figure coordinates massive
		@fcm = f_to_f(@fig_type)
		@fcm.each {|thing|
			thing[0]+=x
			thing[1]+=y
		}
	end
	
	attr_accessor :fig_type
	attr_accessor :fcm
	attr_accessor :fig_x
	attr_accessor :fig_y

	def initialize(x, y, f_type)
		@fig_x = x
		@fig_y = y
		@fig_type = f_type
		count_fig(x, y)
		@block_image = Gosu::Image.new('pix/figs/block.png')
		if @fig_type >=1 and @fig_type <= 7
			@mini_image = Gosu::Image.new("pix/figs/fig#{@fig_type}.png")
		end
		@floor = 19

    @hard_drop_sound = Gosu::Sample.new('sound/fall 4.wav')
    @soft_drop_sound = Gosu::Sample.new('sound/fall 4.wav')
	end

	def drop_sound_play(type)
    volume = 1
		case type
			when true #soft (natural)
				@soft_drop_sound.play(volume)
      when false #hard (manual)
        @hard_drop_sound.play(volume, 1.5)
    end
  end

	def draw (x, y)
		count_fig(x, y)
		4.times do |i|
			@block_image.draw(@fcm[i][0]*20, @fcm[i][1]*20, 0)
		end
	end

	def draw_mini_image (x, y)
		@mini_image.draw(x, y, 0)
	end

	def check_floor
		@fcm.each do |c|
			if c[1] == @floor
				false
				break
			else
				true
			end
		end
	end

	def check_other_figs_down
		a = true
		if $field[@fcm[0][0]][@fcm[0][1]+1] == 1 or ($field[@fcm[1][0]][@fcm[1][1]+1] == 1 or ($field[@fcm[2][0]][@fcm[2][1]+1] == 1 or $field[@fcm[3][0]][@fcm[3][1]+1] == 1))
			a = false
		end
		a
	end

	def morph (fig_type)
		case fig_type
		when 1
			1
		when 2
			21
		when 21
			2
		when 3
			31
		when 31
			3
		when 4
			41
		when 41
			4
		when 5
			51
		when 51
			52
		when 52
			53
		when 53
			5
		when 6
			61
		when 61
			62
		when 62
			63
		when 63
			6
		when 7
			71
		when 71
			72
		when 72
			73
		when 73
			7
		end
	end

	#movement

	def move_left
		a = true 
		@fcm.each do |c|
			if c[0] == 0 or $field[c[0]-1][c[1]] == 1
				a = false
			end
		end
		if a
			@fig_x -= 1
		end
	end

	def move_right
		a = true
		@fcm.each do |c|
			if c[0] == 9 or $field[c[0]+1][c[1]] == 1
				a = false
			end
		end
		if a
			@fig_x += 1
		end
	end

	def drop_down
		while check_floor and check_other_figs_down
			@fig_y+=1
			count_fig(@fig_x, @fig_y)
		end
		$points+=1
	end

	def check_edge
		# 1 left
		# 2 right
		# 0 OK
		a = 0
		@fcm.each do |c|
			if c[0]<0
				a = 1
			elsif c[0]>9
				a = 2
			end
		end
		a
	end



end
