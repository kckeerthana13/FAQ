require './get_input_faqs.rb'
require './reading_from_csv.rb'

$test_data_set = "faq1.csv"

files = GetInputFaqs.get_from_directory
puts "Files to be parsed"
puts files

filename="questions.csv"
ReadingFromCsv.get_input_questions(filename)

#i=0
#until i>4
#for i in (0..5)
 # puts "Enter your question"
  #ques = gets
  #WriteToCsv.write_new_qa(ques)
#  i = i+1
#end