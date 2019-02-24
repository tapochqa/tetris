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

		def get_digit(i, digit)
		i.to_s.split('').fetch(digit-1).to_i
	end

	def int_to_array(i)
		arr = Array.new(4) {0}
		case i.to_s.size
		when 1
			arr[3] = i
		when 2
			arr[2] = get_digit(i, 1)
			arr[3] = get_digit(i, 2)
		when 3
			arr[1] = get_digit(i, 1)
			arr[2] = get_digit(i, 2)
			arr[3] = get_digit(i, 3)
		when 4
			arr[0] = get_digit(i, 1)
			arr[1] = get_digit(i, 2)
			arr[2] = get_digit(i, 3)
			arr[3] = get_digit(i, 4)
		end
		arr
	end

	def update_table(i, table)
		arr = int_to_array(i)
		4.times do |i|
			table[i] = Gosu::Image.new("pix/digits/#{arr[i]}.png", :tileable => false)
		end
		table
	end

	def fupdate	(f, fcm, table)
		fcm.each do |c|
			f[c[0]][c[1]]= 1
		end
		f = rek_rows(f, table)
		f
	end

	def rek_rows (f, table)
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
		update_table($POINTS, table)
		f
	end

	def update_best (table)
		table = update_table($BEST, table)
	end




end

