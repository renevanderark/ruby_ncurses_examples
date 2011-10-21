#!/usr/bin/ruby

require "rubygems"
require "settings"
require "filepicker"

begin
	window = Ncurses.initscr
	Settings.do
	filename = nil
	while(filename.nil?)
		filename = FilePicker.new(window, :header => "Open file").pick_file
	end
	Util.alert(window, "Picked filename: #{filename}") 
ensure
	Ncurses.endwin
end
