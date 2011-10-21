require "settings"
require "linepicker"

class FilePicker < LinePicker
	attr_accessor :relpath, :files, :filter
	def initialize(window, opts = {})
		self.relpath = opts[:relpath] || "."
		self.filter = opts[:filter] || nil
		init_files
		super(window, init_lines, opts[:header])
		self.final_lambdas.merge!({
			27 => lambda{|l| return false}
		})
	end

	def pick_file
		picked_line = pick_line
		file = files[picked_line] if picked_line
		return false unless picked_line
		return change_and_pick(file) if File.directory?(self.relpath + "/" + file)
		return relpath + "/" + file
	end

	private
	def change_and_pick(rpath)
		self.relpath += "/#{rpath}"
		init_files
		self.lines = init_lines
		pick_file
	end

	def init_files
		self.files = Dir.open(relpath).entries.reject do |e| 
			e == "." or (filter and (not File.directory?(relpath + "/" + e) and (not e =~ /#{filter}$/)))
		end.sort do |a,b| 
			(File.directory?(relpath + "/" +a) ? "0" : "Z") + a  <=> (File.directory?(relpath + "/" +b) ? "0" : "Z") + b
		end
	end
	
	def init_lines
		self.files.map do |file|
			{
				:text => file, 
				:color => (File.directory?(relpath + "/" + file) ? Settings::GREEN_LINE : Settings::NORMAL_LINE)
			}
		end
	end
end
