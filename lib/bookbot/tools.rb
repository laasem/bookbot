# tools.rb
#
module BookBot
  module Tools

    # Takes a string. If style is 'ascii' (default), returns an ASCII'd 
    # version of the string, with leading and trailing whitespace removed.
    # If style is 'report', returns an array with words in lower case.
    # Contractions and non-alpha characters have been removed.
    def scrub(string , style = 'ascii' )
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
    module_function :scrub

    # Takes a scrubbed array and returns a float.
    def average_word_length(text_array)
      word_char_count = text_array.inject(0) { |sum,word| sum += word.length }
      avg             = word_char_count.to_f / text_array.length
      return avg.round(1)
    end
    module_function :average_word_length

    # Takes a string, returns a hash with the report data.
    def build_report(string)
      data                    = Hash.new
      str_ascii               = scrub(string)
      arr_report              = scrub(string, 'report')
      data[:chars]            = arr_report.join('').length
      data[:string]           = arr_report.join('')
      data[:sentences]        = str_ascii.count('.') + str_ascii.count('?')
      data[:words]            = arr_report.length
      data[:avg_word_length]  = average_word_length(arr_report) 
      data[:contractions]     = count_contractions(str_ascii)
      data
    end
    module_function :build_report

    def syllables_per_word(word)
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
    module_function :syllables_per_word

    def count_contractions(text)
      apostrophes   = text.scan(/'/).count
      possessives   = text.scan(/'s/).count
      single_open   = text.scan(/ '/).count
      single_close  = text.scan(/' /).count
      single_close  += text.scan(/'\. /).count
      single_close  += text.scan(/', /).count
      single_close  += text.scan(/\.' /).count
      puts "apos #{apostrophes}"
      puts "pos #{possessives}"
      apostrophes - possessives - single_open - single_close
    end
    module_function :count_contractions

    def count_syllables(clean_array)
      syllables = 0 
      clean_array.each { |word|
        syllables += syllables_per_word(word)
      }   
      syllables
    end 
    module_function :count_syllables


  end 
end
