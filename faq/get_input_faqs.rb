class GetInputFaqs
	def self.get_from_directory
		basedir = "/home/kirthana/faq"
		files = (Dir.glob("*.csv")).select {|file| !file.match(/answers/)}
		return files
	end
end