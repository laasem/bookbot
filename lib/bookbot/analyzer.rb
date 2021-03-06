# analyzer.rb
#
module BookBot
  module Analyzer

    public

    # Takes a string, returns a hash with the report data.
    def self.build_report(string)
      data                    = Hash.new
      data[:ascii]            = scrub(string)
      data[:arr_report]       = scrub(data[:ascii], 'report')
      # Just the scrubbed words, or everything?
      #data[:character_count]  = data[:arr_report].join('').length
      data[:character_count]  = data[:ascii].length
      data[:string]           = data[:arr_report].join('')
      data[:sentences]        = data[:ascii].count('.') + data[:ascii].count('?')
      data[:word_count]       = data[:arr_report].length
      data[:avg_word_length]  = average_word_length(data[:arr_report]) 
      data[:contractions]     = count_contractions(data[:ascii])
      data[:syllables]        = count_syllables(data[:arr_report])
      data
    end

    # Contractions and non-alpha characters have been removed.
    def self.scrub(str , style = 'ascii' )
      string = str.clone
      string.gsub!(/\uFEFF/, '')    # BOM
      string.gsub!(/\u2018/, "\'")  # Apos
      string.gsub!(/\u2019/, "\'")  # Apos
      string.gsub!(/\u0060/, "\'")  # Apos
      string.gsub!(/\u00B4/, "\'")  # Apos
      string.gsub!(/\u201C/, "\"")  # Double Quote
      string.gsub!(/\u201D/, "\"")  # Double Quote

      string.gsub!(/\u2026/, "...") # Ellipsis
      string.strip!

      if ( style == 'report' )
        string.downcase!
        string.gsub!(/n't/, ' ')
        string.gsub!(/'ll/, ' ')
        string.gsub!(/'s/, ' ')
        string.gsub!(/'ve/, ' ')
        string.gsub!(/'re/, ' ')
        clean_string = string.gsub(/[,:!.?'"-]/, ' ')
        clean_array  = clean_string.split()
        clean_array.each { |word|
          clean_array.delete(word) unless word =~ /[aeiou]/i
          clean_array.delete(word) if word =~ /^ing/i
        }
        return clean_array
      end
    
      string
    end

    def self.syllables_per_word(word)
      count   = 0 
      vowels  = "aeiouy"
      if vowels.include?(word[0])
        count += 1
      end 
      old_letter = ''
      word.each_char.with_index { |letter, index|
        if index == 0 
          old_letter = letter
          next
        end   
        if vowels.include?(letter)
          count += 1 unless vowels.include?(old_letter) 
        end
        old_letter = letter
      }   
      count -= 1 if word.end_with?('e')
      count = 1 if count < 1
      count
    end 

    # Takes a scrubbed array and returns a float.
    def self.average_word_length(text_array)
      word_char_count = text_array.inject(0) { |sum,word| sum += word.length }
      avg             = word_char_count.to_f / text_array.length
      return avg.round(1)
    end

    def self.count_contractions(text)
      contractions_raw  = text.scan(/[a-zI]'[a-z]/)
      possessives       = text.scan(/[a-z]'s/)  # I's isn't an English word.
      contractions      = contractions_raw - possessives
      contractions.count
    end

    def self.count_syllables(clean_array)
      syllables = 0 
      clean_array.each { |word|
        syllables += syllables_per_word(word)
      }   
      syllables
    end 

  end 
end
