module Settings
	WHITE_ON_BLACK = 1
	GREEN_ON_BLACK = 2
	BLACK_ON_WHITE = 3
	GREEN_ON_WHITE = 4
	RED_ON_WHITE = 5
	RED_ON_BLACK = 6
	YELLOW_ON_WHITE = 7
	YELLOW_ON_BLACK = 8
	BLACK_ON_YELLOW = 9

	GREEN_LINE = {:normal => GREEN_ON_BLACK, :selected => GREEN_ON_WHITE}
	RED_LINE = {:normal => RED_ON_BLACK, :selected => RED_ON_WHITE}
	YELLOW_LINE = {:normal => YELLOW_ON_BLACK, :selected => YELLOW_ON_WHITE}
	NORMAL_LINE = {:normal => WHITE_ON_BLACK, :selected => BLACK_ON_WHITE}

	def self.do
		Ncurses.cbreak
		Ncurses.start_color
		Ncurses.init_pair Settings::GREEN_ON_WHITE, Ncurses::COLOR_GREEN, Ncurses::COLOR_WHITE
		Ncurses.init_pair Settings::BLACK_ON_WHITE, Ncurses::COLOR_BLACK, Ncurses::COLOR_WHITE
		Ncurses.init_pair Settings::GREEN_ON_BLACK, Ncurses::COLOR_GREEN, Ncurses::COLOR_BLACK
		Ncurses.init_pair Settings::WHITE_ON_BLACK, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLACK
		Ncurses.init_pair Settings::RED_ON_WHITE, Ncurses::COLOR_RED, Ncurses::COLOR_WHITE
		Ncurses.init_pair Settings::RED_ON_BLACK, Ncurses::COLOR_RED, Ncurses::COLOR_BLACK
		Ncurses.init_pair Settings::YELLOW_ON_WHITE, Ncurses::COLOR_YELLOW, Ncurses::COLOR_WHITE
		Ncurses.init_pair Settings::YELLOW_ON_BLACK, Ncurses::COLOR_YELLOW, Ncurses::COLOR_BLACK
		Ncurses.init_pair Settings::BLACK_ON_YELLOW, Ncurses::COLOR_BLACK, Ncurses::COLOR_YELLOW
	end
end
