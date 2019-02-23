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

