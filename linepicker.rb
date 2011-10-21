require "settings"
require "util"
require "ncurses"

class LinePicker
	attr_accessor :lines, :window, :lambdas, :final_lambdas, :header, :full_lines

	def initialize(window, lines, header = nil, settings = {})
		self.lines = lines
		self.window = window
		self.header = header
		self.full_lines = settings[:full_lines] || false
		self.final_lambdas = {
			"\n"[0] => lambda{|line| relieve; return line} 
		}
		self.lambdas = {}
	end

	def pick_line
		window.keypad true
		Ncurses.curs_set(0)
		(start_index, maxlines) = draw_lines
		row = 0
		while(ch = window.getch)
			return final_lambdas[ch].call(row) if final_lambdas[ch]
			lambdas[ch].call(row) if lambdas[ch]
			row = 0 if row >= lines.length
			case ch
			when Ncurses::KEY_UP
				row -= 1 if row > 0 
			when Ncurses::KEY_DOWN
				row += 1 if row < lines.length-1
			when Ncurses::KEY_PPAGE
				row -= maxlines
				row = 0 if row < 0
			when Ncurses::KEY_NPAGE
				row += maxlines
				row = lines.length-1 if row > lines.length-1
			end
			(start_index, maxlines) = draw_lines(row, (row >= start_index + maxlines ? row - maxlines : (row < start_index ? row : start_index)  ))
		end
	end

	private
	def relieve
		Ncurses.curs_set(1)
		window.keypad false
	end

	def draw_lines(selected = 0, start_index = 0)
    (maxlines, maxcols) = Util.screendims(window)

		window.clear
		window.attrset(Ncurses.COLOR_PAIR(Settings::BLACK_ON_YELLOW))
		window.addstr("#{header.rstrip}#{" " * (maxcols-header.rstrip.length-1)}\n") if header

		lines[start_index..(start_index + maxlines-(header.nil? ? 1 : 2))].each_with_index do |line, i|
			window.attrset(start_index + i == selected ? Ncurses.COLOR_PAIR(line[:color][:selected]) : Ncurses.COLOR_PAIR(line[:color][:normal]))
			window.addstr("#{line[:text][0..(maxcols-2)]}#{self.full_lines ? " " * ((x = maxcols - line[:text][0..(maxcols-2)].length - 1) > 0 ? x : 0) : ""}\n") 
		end
		window.refresh
		window.attrset(Ncurses.COLOR_PAIR(Settings::WHITE_ON_BLACK))
		return [start_index, maxlines - (header.nil? ? 1 : 2)]
	end
end
