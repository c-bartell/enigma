class ShiftGenerator
  attr_reader :enigma

  def initialize(enigma)
    @enigma = enigma
  end

  def combi_length(key_date_data)
    key_date_data.sum do |datum|
      datum.length
    end
  end

  def pad(string, width)
    string.rjust(width, '0')
  end

  def generate_key
    pad(rand(100_000).to_s, 5)
  end

  def key_date(key_date_data)
    # combined string length: 11, 6, 5, or 0
    #   11 means all good, return key_date_data
    #   Not 11 means correct the data
    # return key_date_data if key_date_data.length == 2
    # if key_date_data.first.length == 6
    #   #generate key and add to beginning
    # elsif key_date_data
    # require 'pry' ; binding.pry
  end
end
