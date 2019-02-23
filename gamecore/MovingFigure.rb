class MovingFigure

	def f_to_f (fig_type)
		
		f = Array.new() {[]}
		c = Array.new(2, 0)

		IO.foreach("gamecore/#{fig_type}") do |line|
			line.split('').each do |symbol|
				if symbol == '1'
					f.push([c[0], c[1]])
				end
				c[0]+=1
			end
			c[0]=0
			c[1]+=1
		end
		$fig_width = f[0].size
		f
	end


	def countfig (x, y)
		# $fcm is figure coordinates massive
		$fcm = f_to_f(@figtype)
		$fcm.each do |thing|
			thing[0]+=x
			thing[1]+=y
		end
	end
	
	attr_accessor :figtype

	def initialize(x, y)
		$figx = x
		$figy = y
		@figtype = 1+rand(6)
		countfig(x, y)
		@blockimage = Gosu::Image.new("pix/figs/block.png")
		@mini_image = Gosu::Image.new("pix/figs/fig#{@figtype}.png")
	end
	def draw (x, y)
		countfig(x, y)
		4.times do |i|
			@blockimage.draw($fcm[i][0]*20, $fcm[i][1]*20, 0)
		end
	end

	def draw_mini_image (x, y)
		@mini_image.draw(x, y, 0)
	end

	def check_floor
		floor = 19
		$fcm.each do |c|
			if c[1] == floor
				false
				break
			else
				true
			end
		end
	end

	def check_other_figs_down
		a = true
		if $FIELD [$fcm[0][0]][$fcm[0][1]+1] == 1 or ($FIELD [$fcm[1][0]][$fcm[1][1]+1] == 1 or ($FIELD [$fcm[2][0]][$fcm[2][1]+1] == 1 or $FIELD [$fcm[3][0]][$fcm[3][1]+1] == 1))
			a = false
		end
		a
	end
end
