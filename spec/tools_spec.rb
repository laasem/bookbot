# tools_spec.rb
#

require 'bookbot'
module BookBot

  RSpec.describe 'Tools' do

    test_file   = 'spec/data/test_section.txt'
    let(:section) { BookBot::Section.new(test_file) }

    it 'converts a UTF-8 string to ascii' do
      string      = " \u201D h\u2026i \u201D "
      new_string  = Tools.scrub(string, 'ascii')
      expect(new_string).to eq('" h...i "')
    end

    it 'removes apostrophe words' do
      string      = "  We'll wentn't to's your've home're   "
      new_string  = Tools.scrub(string, 'report')
      expect(new_string).to eq(["we", "went", "to", "your", "home"])
    end

    it 'generates a hash with report data' do
      string  = " We'll look at the stuff you have. It looks pretty? Really.   "
      report  = Tools.build_report(string)
      expect(report.class).to be(Hash)
      expect(report[:chars]).to be(42)
      expect(report[:string]).to eq('welookatthestuffyouhaveitlooksprettyreally')
      expect(report[:sentences]).to eq(3)
      expect(report[:words]).to be(11)
      expect(report[:avg_word_length]).to be(3.8)
    end

    it 'generates a word length' do
      string      = " We'll look at the stuff you have. It looks pretty? Really.   "
      arr_report  = Tools.scrub(string, 'report')
      expect(Tools.average_word_length(arr_report)).to eq(3.8)
    end

    it 'counts syllables per word' do
      word1     = "pret"
      word2     = "pretty"
      word3     = "prettyni"
      word4     = "prettynicly"
      expect(Tools.syllables_per_word(word1)).to be(1)
      expect(Tools.syllables_per_word(word2)).to be(2)
      expect(Tools.syllables_per_word(word3)).to be(3)
      expect(Tools.syllables_per_word(word4)).to be(4)
    end

    it 'counts syllables' do
      sentences      = " We'll look at the stuff you have. It looks pretty? Really.   "
      arr_report  = Tools.scrub(sentences, 'report')
      expect(Tools.count_syllables(arr_report)).to be(13)
    end 

    it 'counts_contractions' do
      sentence1   = "We'll look in on you later."
      sentence2   = "We'd like to, but can't."
      sentence2a  = "We'd like to, can't you? They had asked. 'No,' she said."
      expect(Tools.count_contractions(sentence1)).to  be(1)
      expect(Tools.count_contractions(sentence2)).to  be(2)
      expect(Tools.count_contractions(sentence2a)).to be(2)
    end

  end
end

