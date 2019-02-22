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
		floor = 100

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



class Field
	def initialize
		#0 - empty
		#1 - static
		$FIELD = Array.new(200, 0)
		@staticblock = Gosu::Image.new("pix/figs/static.png")
		@counter = 0
	end

	def draw(i, j)
		@staticblock.draw(i*20, j*20, 0)
	end


	def recount
		if @counter == 20
			$moving = true
			@counter = 0
		else
			@counter +=1
			$moving = false
		end
	end

	def count_xy(x, y)
		a = x
		b = y
		a+b/10
	end

	def fupdate	(f)
		a = count_xy($b1x, $b1y).to_i
		b = count_xy($b2x, $b2y).to_i
		c = count_xy($b3x, $b3y).to_i
		d = count_xy($b4x, $b4y).to_i
		f[a] = 1
		puts a
		f[b] = 1
		puts b
		f[c] = 1
		puts c
		f[d] = 1
		puts d
		puts rand()
		f
	end

	def debug
		20.times do |i|
			puts
			10.times do |j|
				if $FIELD[i+j*10]== 1
					print '* '
				else print '. '
				end 
			end
		end
	puts
	puts '===END==='
	end
end

