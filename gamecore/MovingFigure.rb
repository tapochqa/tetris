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
		@block_image = Gosu::Image.new("pix/figs/block.png")
		if @fig_type >=1 and @fig_type <= 7
			@mini_image = Gosu::Image.new("pix/figs/fig#{@fig_type}.png")
		end
		@floor = 19
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

end
