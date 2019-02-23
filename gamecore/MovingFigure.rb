class MovingFigure
	def countfig (x, y)
		case @figtype
		when 1
			##
			##
			$b1x = x
			$b1y = y
			$b2x = x+10
			$b2y = y
			$b3x = x
			$b3y = y+10
			$b4x = x+10
			$b4y = y+10
		when 2
			####
			$b1x = x
			$b1y = y
			$b2x = x+10
			$b2y = y
			$b3x = x+20
			$b3y = y
			$b4x = x+30
			$b4y = y
		when 3
			#
			##
			 #
			$b1x = x
			$b1y = y
			$b2x = x
			$b2y = y+10
			$b3x = x+10
			$b3y = y+10
			$b4x = x+10
			$b4y = y+20
		when 4
			 #
			##
			#
			$b1x = x+10
			$b1y = y
			$b2x = x
			$b2y = y+10
			$b3x = x+10
			$b3y = y+10
			$b4x = x
			$b4y = y+20
		when 5
			#
			#
			##
			$b1x = x
			$b1y = y
			$b2x = x+10
			$b2y = y
			$b3x = x+20
			$b3y = y+10
			$b4x = x+20
			$b4y = y
		when 6
			 #
			 #
			##
			$b1x = x+10
			$b1y = y
			$b2x = x+10
			$b2y = y+10
			$b3x = x+10
			$b3y = y+20
			$b4x = x
			$b4y = y+20
		end
	end
	def initialize(x, y)
		$figx = x
		$figy = y
		@figtype = 1+rand(6)
		countfig(x, y)
		@blockimage = Gosu::Image.new("pix/figs/block.png")
	end
	def draw (x, y)
		countfig(x, y)
		@blockimage.draw($b1x*2, $b1y*2, 0)
		@blockimage.draw($b2x*2, $b2y*2, 0)
		@blockimage.draw($b3x*2, $b3y*2, 0)
		@blockimage.draw($b4x*2, $b4y*2, 0)

	end

	def moving
		floor = 170

		if $b1y >= floor
			if $b2y >= floor
				if $b3y >= floor
					if $b4y >= floor
						false
					end
				end
			end
		else
			true
		end
	end

end