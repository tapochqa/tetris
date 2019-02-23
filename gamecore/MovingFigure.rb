class MovingFigure
	def countfig (x, y)
		case @figtype
		when 1
			##
			##
			$b1x = x
			$b1y = y
			$b2x = x+1
			$b2y = y
			$b3x = x
			$b3y = y+1
			$b4x = x+1
			$b4y = y+1
		when 2
			####
			$b1x = x
			$b1y = y
			$b2x = x+1
			$b2y = y
			$b3x = x+2
			$b3y = y
			$b4x = x+3
			$b4y = y
		when 3
			#
			##
			 #
			$b1x = x
			$b1y = y
			$b2x = x
			$b2y = y+1
			$b3x = x+1
			$b3y = y+1
			$b4x = x+1
			$b4y = y+2
		when 4
			 #
			##
			#
			$b1x = x+1
			$b1y = y
			$b2x = x
			$b2y = y+1
			$b3x = x+1
			$b3y = y+1
			$b4x = x
			$b4y = y+2
		when 5
			#
			#
			##
			$b1x = x
			$b1y = y
			$b2x = x+1
			$b2y = y
			$b3x = x+2
			$b3y = y+1
			$b4x = x+2
			$b4y = y
		when 6
			 #
			 #
			##
			$b1x = x+1
			$b1y = y
			$b2x = x+1
			$b2y = y+1
			$b3x = x+1
			$b3y = y+2
			$b4x = x
			$b4y = y+2
		end
	end
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
		@blockimage.draw($b1x*20, $b1y*20, 0)
		@blockimage.draw($b2x*20, $b2y*20, 0)
		@blockimage.draw($b3x*20, $b3y*20, 0)
		@blockimage.draw($b4x*20, $b4y*20, 0)

	end

	def draw_mini_image (x, y)
		@mini_image.draw(x, y, 0)
	end

	def check_floor
		floor = 19
		if $b1y == floor or ($b2y == floor or ($b3y == floor or $b4y == floor))
			false
		else
			true
		end
	end

	def check_other_figs_down
		a = true
		if $FIELD [$b1x][$b1y+1] == 1 or ($FIELD [$b2x][$b2y+1] == 1 or ($FIELD [$b3x][$b3y+1] == 1 or $FIELD [$b4x][$b4y+1] == 1))
			a = false
		end
		a
	end

end