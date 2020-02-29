# scene_spec.rb
#
#$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'ftl_book'
module FTLBook
  RSpec.describe do
    test_file   = 'spec/data/test_scene.txt'
    let(:scene) { FTLBook::Scene.new(test_file) }

    it 'should count contractions' do
      # known issue with counting single quoted sentences, and 
      # possessives.
      expect(scene.contraction_count).to eq(52)
    end

    it 'should count sentences' do
      expect(scene.count_sentences).to eq(131)
    end

    it 'should count words' do
      expect(scene.count_words).to eq(781)
    end

    it 'should get an average word length' do
      expect(scene.average_word_length).to eq(3.9)
    end

    it 'counts characters' do
      expect(scene.char_count).to eq(4291)
    end

    it 'has a file_name_label' do
      odd_scene_file_name = 'spec/data/Al and Jo talk.htmlpdq'
      odd_scene_file = FTLBook::Scene.new(odd_scene_file_name)
      expect(odd_scene_file.file_name_label).to eq('al_and_jo_talk')
    end

    it 'can accept a title' do
      scene.title = 'Al and Jo talk'
      expect(scene.title).to eq('Al and Jo talk')
    end

    it 'has a grade_level score' do
      expect(scene.grade_level).to eq(2.3)
    end

  end
end
