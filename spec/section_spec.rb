# section_spec.rb
#
#$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'ftl_book'
module FTLBook
  RSpec.describe 'A section' do
    test_file   = 'spec/data/test_section.txt'
    let(:section) { FTLBook::Section.new(test_file) }

    it 'should count contractions' do
      # known issue with counting single quoted sentences, and 
      # possessives.
      expect(section.contraction_count).to eq(52)
    end

    #it 'can tell if the file has a BOM' do
    #  expect(section.has_bom?).to be_truthy
    #end

    it 'scrubs non-ASCII characters' do
      scrub_test_section   = FTLBook::Section.new('spec/data/line_scene_bom_quotes.txt')
      fixed_line  = "\"With last year's pants,\" Wilbur chuckled. \"Didn't he used to wear old pants?\"" 
      expect(scrub_test_section.to_s).to match(fixed_line)
    end

    it 'should count sentences' do
      expect(section.count_sentences).to eq(131)
    end

    it 'should count words' do
      expect(section.count_words).to eq(781)
    end

    it 'should get an average word length' do
      expect(section.average_word_length).to eq(3.9)
    end

    it 'counts characters' do
      expect(section.char_count).to eq(4290)
    end

    it 'has a file_name_label' do
      odd_section_file_name = 'spec/data/Al and Jo talk.htmlpdq'
      odd_section_file = FTLBook::Section.new(odd_section_file_name)
      expect(odd_section_file.file_name_label).to eq('al_and_jo_talk')
    end

    it 'can accept a title' do
      section.title = 'Al and Jo talk'
      expect(section.title).to eq('Al and Jo talk')
    end

    it 'has a grade_level score' do
      expect(section.grade_level).to eq(2.3)
    end

    it 'removes the BOM' do

    end

  end
end
