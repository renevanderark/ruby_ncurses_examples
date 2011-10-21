#!/usr/bin/ruby

require "rubygems"
require "ncurses"
require "settings"
require "filepicker"

begin
	window = Ncurses.initscr
	Settings.do
	filename = FilePicker.new(window, :header => "Open file").pick_file
	if filename
		Util.alert(window, "Picked filename: #{filename}") 
	else
		Util.alert(window, "You got away clean!")
	end
ensure
	Ncurses.endwin
end
