require './write_to_csv.rb'
require 'csv'
require 'byebug'

class ReadingFromCsv
  def self.get_array_of_qa(filename)
    col_data = []
    CSV.foreach(filename,"r") do |row|
      ans = row[1]
      unless ans.to_s.empty?
        temp = row[0]
        col_data << temp
        temp = row[1]
        col_data << temp
      end
    end
    return col_data
  end

  def self.get_input_questions(filename)
    CSV.foreach(filename, "r") do |row|
     ques = row[0]
     puts "Question:"
     puts ques
     WriteToCsv.write_new_qa(ques)
    end
  end
end
