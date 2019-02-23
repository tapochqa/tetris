class Field
	def initialize
		#0 - empty
		#1 - static
		$FIELD = Array.new(10) { Array.new(20, 0)  }

		@staticblock = Gosu::Image.new("pix/figs/static.png")
		@counter = 0
	end

	def draw(i, j)
		@staticblock.draw(i*20, j*20, 0)
	end


	def recount
		if @counter == 17
			$moving = true
			@counter = 0
		else
			@counter +=1
			$moving = false
		end
	end

	def fupdate	(f)
		f[$b1x][$b1y] = 1
		f[$b2x][$b2y] = 1
		f[$b3x][$b3y] = 1
		f[$b4x][$b4y] = 1
		f
	end

end

