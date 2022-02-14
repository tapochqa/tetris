class Field
	def initialize
		#0 - empty
		#1 - static
		$field = Array.new(10) { Array.new(20, 0)  }
		@clean_row = Array.new(10) {0}
		@full_row = Array.new(10) {1}
		@static_block = Gosu::Image.new('pix/figs/static.png')
		@counter = 0
    @rek_sound = Array.new(4) {|i| Gosu::Sample.new("sound/rows #{i+1}.wav")}
	end

	def draw(i, j)
		@static_block.draw(i*20, j*20, 0)
	end


	def recount
		if @counter == $speed
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
    rek_rows(f)
	end

	def rek_rows (f)

		bonus = 0
    	rows = 0
		flipped = f.transpose
		flipped.delete(@full_row)
		until flipped.size == 20
			flipped.unshift (@clean_row)
      		rows+=1
			if bonus == 0
				bonus+=5
			else
				bonus*=3
			end
		end
		f = flipped.transpose
		$points+=bonus
		#$speed-=1 if bonus > 0
    @rek_sound[rows-1].play(1) if rows>0
		f
	end




end

