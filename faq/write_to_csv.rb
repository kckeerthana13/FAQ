require 'csv'
require './find_answers.rb'
require 'byebug'

class WriteToCsv
	def self.write_new_qa(question)
		ans = FindAnswers.select_answer(question)
		CSV.open("questions_answers.csv","a+") do |csv|
			csv << [question, ans]
		end
	end

	def self.update_corpus(question, answer)
		CSV.open("faq1.csv","a+") do |csv|
			csv << [question, answer]
		end
	end
end