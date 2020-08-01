# scene.rb
#
module BookBot
  class Section

    attr_accessor :chapter_number, :header, :title
     
    def initialize(file)
      @file_name  = File.basename(file, '.*').downcase
      file_string = slurp_file(file)
      @string     = Tools.scrub(file_string) 

      # Report stuff
      @clean_array = Tools.scrub(@string.clone, 'report')
      count_words
      count_sentences
      count_syllables
    end


    def slurp_file(file)
      file_string = ''
      File.open(file) { |f|
        file_string = f.read
      }
      file_string
    end 

    def file_name_label
      label = @file_name.gsub(/ /, "_").to_s
      label.gsub!(/[^a-z0-9_]/, "")
      label = "_" +  label
      label.to_sym
    end

    def to_s
      @string
    end

    def char_count
      @string.length
    end
   
    def count_sentences
      @sentences = @string.count('.') + @string.count('?')
    end
   
    def average_word_length
      word_char_count = @clean_array.inject(0) { |sum, word| sum += word.length }
      avg = word_char_count.to_f / @clean_array.length
      avg.round(1)
    end
      
    def count_words
      @word_count = @clean_array.length
    end 

    def syllables_per_word(word)
      count   = 0
      vowels  = "aeiouy"
      if vowels.include?(word[0])
        count += 1
      end
      word.each_char.with_index { |letter, index|
        next if index == 0  
        if vowels.include?(letter)
           unless vowels.include?(word[word.index(letter) - 1])
              count += 1
           end
        end
      }
      count -= 1 if word.end_with?('e')
      count += 1 if count == 0
      count
    end

    def count_syllables
      @syllables = 0
      @clean_array.each { |word|
        @syllables += syllables_per_word(word)
      }
      @syllables
    end

    def contraction_count
      # this falsely reports single quoted strings, and possessives.
      @string.count("'")
    end

    def grade_level
      # https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests
      # 0.39 * ( total_words / total_sentences ) 
      # + 11.8 * ( total_syllables / total_words )
      # - 15.59
      #
      level = 0.39 * ( @word_count.to_f / @sentences )
      level += 11.8 * ( @syllables.to_f / @word_count )
      level -= 15.59
      level.round(1) 
    end

    def report
      grade_level
    end

  end
end
