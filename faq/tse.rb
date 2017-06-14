require './write_to_csv.rb'
require './get_input_faqs.rb'

files = GetInputFaqs.get_from_directory
puts "Files to be parsed"
puts files

#i=0
#until i>4
for i in (0..5)
  puts "Enter your question"
  ques = gets
  WriteToCsv.write_new_qa(ques)
#  i = i+1
end