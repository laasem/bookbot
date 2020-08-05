# analyzer_spec.rb
#

require 'bookbot'
module BookBot
  module Analyzer
    RSpec.describe 'Analyzer' do

      #test_file   = 'spec/data/test_section.txt'
      #let(:section) { BookBot::Section.new(test_file) }
      #let ( :analyzer ) { Analyzer.build_report() }

      it 'converts a UTF-8 string to ascii' do
        string  = " \u201D h\u2026i \u201D "
        data    = Analyzer.build_report(string)
        expect(data[:ascii]).to eq('" h...i "')
      end

      it 'removes apostrophe words' do
        string  = "  We'll wentn't to's your've home're   "
        data    = Analyzer.build_report(string)
        expect(data[:string]).to eq("wewenttoyourhome")
      end

      it 'generates a hash with report data' do
        string  = " We'll look at the stuff you have. It looks pretty? Really.   "
        data    = Analyzer.build_report(string)
        expect(data.class).to be(Hash)
        expect(data[:character_count]).to be(58)
        expect(data[:string]).to eq('welookatthestuffyouhaveitlooksprettyreally')
        expect(data[:sentences]).to eq(3)
        expect(data[:word_count]).to be(11)
        expect(data[:avg_word_length]).to be(3.8)
        expect(data[:contractions]).to be(1)
      end

      it 'counts syllables per word' do
        word1     = "pret"
        word2     = "pretty"
        word3     = "prettyni"
        word4     = "prettynicly"
        expect(Analyzer.syllables_per_word(word1)).to be(1)
        expect(Analyzer.syllables_per_word(word2)).to be(2)
        expect(Analyzer.syllables_per_word(word3)).to be(3)
        expect(Analyzer.syllables_per_word(word4)).to be(4)
      end

      it 'counts syllables' do
        sentence  = " We'll look at the stuff you have. It looks pretty? Really.   "
        data      = Analyzer.build_report(sentence)
        expect(Analyzer.count_syllables(data[:arr_report])).to be(13)
      end 

      it 'counts_contractions' do
        sentence1   = "We'll look in on you later."
        sentence2   = "We'd like to, but can't."
        sentence2a  = "We'd like to, can't you? They had asked. 'No,' she said."
        expect(Analyzer.count_contractions(sentence1)).to  be(1)
        expect(Analyzer.count_contractions(sentence2)).to  be(2)
        expect(Analyzer.count_contractions(sentence2a)).to be(2)
      end

    end
  end
end

