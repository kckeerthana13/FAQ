require 'similarity'
require './reading_from_csv.rb'
require 'byebug'

class SimilarityMatrix
  def self.get_stored_corpus
    corpus = Corpus.new
    col_data = ReadingFromCsv.get_array_of_qa("faq1.csv")
    col_data.each do |headline|
      # create a document object from the headline
      document = Document.new(:content => headline)
      # add the document to the corpus
      corpus << document
    end
    corpus
  end

  def self.add_to_corpus(question)
    corpus = self.get_stored_corpus
    indoc = Document.new(:content => question)
    corpus << indoc
    corpus
  end

  def self.get_similarity_matrix(question)
    corpus = self.add_to_corpus(question)
    corpus.similarity_matrix
  end

  def self.get_document_obj_from_corpus(question)
    self.add_to_corpus(question).documents
  end
end