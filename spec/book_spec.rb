# book_spec.rb
#
require 'bookbot'
module BookBot

  RSpec.describe 'A book' do

    let ( :prologue )   { BookBot::Section.new('spec/data/prologue.txt') }
    let ( :epilogue )   { BookBot::Section.new('spec/data/epilogue.txt') }
    let ( :chapter_1 )  { BookBot::Section.new('spec/data/chapter_1.txt') }
    let ( :chapter_2 )  { BookBot::Section.new('spec/data/chapter_2.txt') }
    let ( :s_list )     {{ prologue.file_name_label => prologue,
      chapter_1.file_name_label => chapter_1,
      chapter_2.file_name_label => chapter_2,
      epilogue.file_name_label  => epilogue,
    }}

    # This doesn't set the chapter numbers. It has to be called.
    let ( :set_chapters )  {  
      chapter_1.chapter_number = 1, chapter_2.chapter_number = 2,
      chapter_1.set_header, chapter_2.set_header
      }

    let ( :data ) { { 
      title:    "The Life and Death of Al",
      pre:      [ 'prologue' ],
      post:     [ 'epilogue' ],
      book_dir: 'output',
      sections: s_list,
      } }

    let ( :book ) { set_chapters; BookBot::Book.new(data) }

    it 'has a title' do
      expect(book.title).to eq("The Life and Death of Al")
    end

    it 'can have a prologue' do
      expect(book.section_list).to include("prologue")
    end

    it 'has chapters' do
      expect(book.section_list).to include("chapter_1")
      expect(book.section_list).to include("chapter_2")
    end

    it 'can have an epilogue' do
      expect(book.section_list).to include("epilogue")
    end

    it 'creates a text file' do
      book.write_text
      expect(File.file?("output/the_life_and_death_of_al.txt")).to be_truthy
    end

    it 'creates a LaTeX file' do
      book.write_latex
      expect(File.file?("output/the_life_and_death_of_al.tex")).to be_truthy
    end

  end
end

