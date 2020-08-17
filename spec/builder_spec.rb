# builder_spec.rb
#

require 'bookbot'
module BookBot

    RSpec.describe 'A book builder' do
      let ( :data ) { { 
        title:          "Navak Sen",
        sections:       ["ch_1", "ch_2"],
        pre_sections:   ["title", "prologue"],
        post_sections:  ["epilogue", "afterward"],
        } }

      let ( :book ) { BookBot::Builder.new(data) }

      it 'has a title' do
        expect(book.title).to eq("Navak Sen")
      end

      it 'has a title string' do
        expect(book.title_string).to eq("navak_sen")
      end

      it 'has a list of pre-sections' do
        expect(book.pre_sections).to eq(["title", "prologue"])
      end

      it 'has a list of post-sections' do
        expect(book.post_sections).to eq(["epilogue", "afterward"])
      end

      it 'has a section list' do
        expect(book.section_list).to eq(["title", "prologue", "ch_1", "ch_2", 
          "epilogue", "afterward"])
      end

  end
end
