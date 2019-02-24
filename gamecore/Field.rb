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

	def fupdate	(f, fcm)
		fcm.each do |c|
			f[c[0]][c[1]]= 1
		end
		f = rek_rows(f)
		f
	end

	def check_full_rows
		rows_to_rek = []
		20.times do |i|
			full_in_row = 0
			10.times do |j|
				if $FIELD [j][i] == 1 
					full_in_row+=1
				end
			end

			if full_in_row == 10
				rows_to_rek.push(i)
			end
		end
		rows_to_rek
	end

	def rek_rows (f)
		clean_row = Array.new(10) {0}
		full_row = Array.new(10) {1}
		bonus = 0
		flipped = f.transpose
		flipped.delete(full_row)
		until flipped.size == 20
			flipped.unshift (clean_row)
			if bonus == 0
				bonus+=1
			else
				bonus*=3
			end
		end
		f = flipped.transpose
		$POINTS+=bonus
		f
	end




end

