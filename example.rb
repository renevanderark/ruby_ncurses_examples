#!/usr/bin/ruby

require "rubygems"
require "ncurses"
require "settings"
require "filepicker"

begin
	window = Ncurses.initscr
	Settings.do
	filename = nil
	while(filename.nil?)
		filename = FilePicker.new(window, :header => "Open file").pick_file
	end
	if filename
		Util.alert(window, "Picked filename: #{filename}") 
	else
		Util.alert(window, "You got away clean!")
	end
ensure
	Ncurses.endwin
end
