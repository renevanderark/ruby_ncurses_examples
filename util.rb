require "ncurses"

module Util
	def self.alert(window, msg)
		window.attrset(Ncurses.COLOR_PAIR(Settings::BLACK_ON_YELLOW))
		window.move(0,0)
		window.addstr(msg)
		window.refresh
		Ncurses.napms 1500
		window.attrset(Ncurses.COLOR_PAIR(Settings::WHITE_ON_BLACK))
	end

	def self.input(window, msg, xpos = 0, maxlen = nil, validation = nil, valmsg = nil)
		while(true)
			(maxrows, maxcols) = Util.screendims(window)
			window.move(0,0)
			window.addstr("#{msg}#{" " * (maxcols-2-msg.length)}")
			window.refresh
			(input, a, b) = (maxlen.nil? ? Util.read_line(0,xpos, window) : Util.read_line(0,xpos, window, maxlen))
			break if input.nil? || validation.nil? || validation.call(input)
			alert(window, valmsg) if valmsg
		end
		return input
	end

	def self.screendims(window)
		rows = []
		cols = []
		window.getmaxyx(rows, cols)
		return [rows[0], cols[0]]
	end

	def self.read_line(y, x,
              window = Ncurses.stdscr,
              max_len = (window.getmaxx - x - 1),
              string = "",
              cursor_pos = 0)
	  loop do
  	  window.mvaddstr(y,x,string)
    	window.move(y,x+cursor_pos)
	    ch = window.getch
  	  case ch
    	when Ncurses::KEY_LEFT
	      cursor_pos = [0, cursor_pos-1].max
  	  when Ncurses::KEY_RIGHT
    	  # similar, implement yourself !
	    when Ncurses::KEY_ENTER, ?\n, ?\r
  	    return string, cursor_pos, ch # Which return key has been used?
	    when Ncurses::KEY_BACKSPACE
  	    string = string[0...([0, cursor_pos-1].max)] + string[cursor_pos..-1]
    	  cursor_pos = [0, cursor_pos-1].max
	      window.mvaddstr(y, x+string.length, " ")
	    when 27
				return nil
	    when " "[0]..255 # remaining printables
  	    if (cursor_pos < max_len)
    	    string[cursor_pos,0] = ch.chr
	        cursor_pos += 1
  	    else
	        Ncurses.beep
  	    end
    	else
	      Ncurses.beep
  	  end
	  end
	end 
end
