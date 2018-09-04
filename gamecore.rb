#!usr/bin/env ruby
require 'gosu'

$b1x, $b2x, $b3x, $b4x, $b1y, $b2y, $b3y, $b4y = 0

class Figure

	def initialize(x, y)
		$figx.push(50)
		$figy.push(0)
		@figtype = 1+rand(6)
		@blockimage = Gosu::Image.new("pix/figs/block.png")
	end
	def draw (x, y)
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
		@blockimage.draw($b1x, $b1y, 0)
		@blockimage.draw($b2x, $b2y, 0)
		@blockimage.draw($b3x, $b3y, 0)
		@blockimage.draw($b4x, $b4y, 0)

	end

	def moving
		floor = 100

		if $b1y >= floor
			if $b1y >= floor
				if $b1y >= floor
					if $b1y >= floor
						if $b1y >= floor
							if $b1y >= floor
								return false
							end
						end
					end
				end
			end
		else
			return true
		end
	end

end

class Field
	def initialize
		#
	end

	@@counter = 0

	def recount
		if @@counter == 20
			$moving = true
			@@counter = 0
		else
			@@counter = @@counter+1
			$moving = false
		end
	end
end
