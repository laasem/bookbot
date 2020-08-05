# scene.rb
#
module BookBot

  class Section

    attr_accessor :chapter_number, :header, :title
     
    def initialize(file)
      @file_name  = File.basename(file, '.*').downcase
      file_string = slurp_file(file)
      @string     = Analyzer.scrub(file_string) 
      @analysis   = Analyzer.build_report(@string)
    end

    def word_count
      @analysis[:words]
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

    def character_count
      # This currently counts all characters: spaces, punctuation, etc.
      @analysis[:character_count]
    end
   
    def sentence_count
      @analysis[:sentences]
    end
   
    def average_word_length
      @analysis[:avg_word_length]
    end

    def contraction_count
      @analysis[:contractions]
    end

    def syllables
      @analysis[:syllables]
    end

    def word_count
      @analysis[:word_count]
    end

    def grade_level
      # https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests
      # 0.39 * ( total_words / total_sentences ) 
      # + 11.8 * ( total_syllables / total_words )
      # - 15.59
      #
      level = 0.39 * ( word_count.to_f / sentence_count )
      level += 11.8 * ( syllables / word_count.to_f )
      level -= 15.59
      level.round(1) 
    end

  end
end
