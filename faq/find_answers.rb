require './similarity_matrix.rb'
require './reading_from_csv.rb'
require 'byebug'
class FindAnswers
  def self.similarity_hash(question)
    similarity_matrix = SimilarityMatrix.get_similarity_matrix(question)
    documents = SimilarityMatrix.get_document_obj_from_corpus(question)
    col_data = ReadingFromCsv.get_array_of_qa("faq1.csv")
    in_index = documents.size-1
    sim_hash = Hash.new
    documents.each_with_index do |doc1, index1|
      similarity = similarity_matrix[in_index, index1]
      sim_hash[index1]=similarity
    end
    return sim_hash
  end

  def self.get_answers(question)
    sim_hash = self.similarity_hash(question)
    v = sim_hash.sort_by {|_key, value| -value}
    v = v[0...5]
    return v
  end

  def self.print_qa(question)
    v = self.get_answers(question)
    documents = SimilarityMatrix.get_document_obj_from_corpus(question)
    col_data = ReadingFromCsv.get_array_of_qa("faq1.csv")
    in_index = documents.size-1
    i = 1
    relevant_answers = Hash.new
    v.each do |k,v|
      unless k==in_index
        if (k%2==0)
          ques = col_data[k]
          if col_data[k+1].downcase.eql?("see above") || col_data[k+1].downcase.eql?("refer above")
            ans = col_data[k-1]
          else
            ans = col_data[k+1]
          end
        end
        if (k%2==1)
          ques = col_data[k-1]
          ans = col_data[k]
        end
        relevant_answers[i]=[ques, ans]
        i = i+1
      end
    end
    return relevant_answers
  end

  def self.choose_answer(question)
    relevant_answers = print_qa(question)
    relevant_answers.each do |k,v|
      puts "Option #{k}"
      puts v[0]
      puts v[1]
    end
    puts "Select an appropriate answer ( 1 - 4). If none of the answers are appropriate, enter any key"
    ch = gets
    return ch
  end

  def self.select_answer(question)
    ch = choose_answer(question).to_i
    relevant_answers = print_qa(question)
    if (1...4).member?(ch)
      selected = relevant_answers[ch][1]
    else
      selected = set_answer(question)
      WriteToCsv.update_corpus(question, selected)
    end
    return selected
  end

  def self.set_answer(question)
    puts "Enter the correct response to this question"
    ans = gets
    return ans
  end
end
