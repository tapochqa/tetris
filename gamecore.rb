#!usr/bin/env ruby
require 'gosu'



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
		countfig(x, y)
		@figtype = 1+rand(6)
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
		#0 - empty
		#1 - static
		$FIELD = Array.new(200, 0)
		@staticblock = Gosu::Image.new("pix/figs/static.png")
	end

	def draw(i, j)
		@staticblock.draw(i*20, j*20, 0)
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

	def fupdate
		$FIELD[$b1x.to_i+$b1y.to_i/10] = 1
		$FIELD[$b2x.to_i+$b2y.to_i/10] = 1
		$FIELD[$b3x.to_i+$b3y.to_i/10] = 1
		$FIELD[$b4x.to_i+$b4y.to_i/10] = 1
	end

	def debug
		10.times do |i|
			puts
			20.times do |j|
				print $FIELD[j+i*10] 
			end
		end
	end
end

