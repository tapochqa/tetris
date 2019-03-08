class Table
	def initialize
		@table = Array.new(4) { Gosu::Image.new('pix/digits/0.png', :tileable => false) }
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

	def t_update(i)
		arr = int_to_array(i)
		4.times {|j| @table[j] = Gosu::Image.new("pix/digits/#{arr[j]}.png", :tileable => false)}
		@table
	end

	def draw_table (x, y)
		@table.each {|pic|
			pic.draw(x, y, 0)
			x+=20
		}
	end
end