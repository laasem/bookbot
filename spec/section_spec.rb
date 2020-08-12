# section_spec.rb
#

require 'bookbot'
module BookBot
  RSpec.describe 'A section' do
    test_file   = 'spec/data/test_section.txt'
    let(:section) { BookBot::Section.new( test_file, true ) }

    it 'should count contractions' do
      expect(section.contraction_count).to be(20)
    end

    it 'scrubs non-ASCII characters' do
      scrub_test_section   = BookBot::Section.new('spec/data/line_scene_bom_quotes.txt')
      fixed_line  = "\"With last year's pants,\" Wilbur chuckled. \"Didn't he used to wear old pants?\"" 
      expect(scrub_test_section.to_s).to match(fixed_line)
    end

    it 'should count sentences' do
      expect(section.sentence_count).to eq(129)
    end

    it 'should count words' do
      expect(section.word_count).to eq(777)
    end

    it 'should get an average word length' do
      expect(section.average_word_length).to eq(3.9)
    end

    it 'has a file_name_label' do
      odd_section_file_name = 'spec/data/Al and Jo talk.htmlpdq'
      odd_section_file = BookBot::Section.new(odd_section_file_name)
      expect(odd_section_file.file_name_label).to eq(:al_and_jo_talk)
    end

    it 'can accept a title' do
      section.title = 'Al and Jo talk'
      expect(section.title).to eq('Al and Jo talk')
    end

    it 'has a grade_level score' do
      expect(section.grade_level).to eq(1.9)
    end

    it 'has a header' do
      expect(section.header).to match(/^\[14.*\] .*Hall$/)
      expect(section.to_s).to match(/^The training/)
    end

  end
end
