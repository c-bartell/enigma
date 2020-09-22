class ShiftGenerator
  attr_reader :enigma

  def initialize(enigma)
    @enigma = enigma
  end

  def combi_length(key_date_data)
    key_date_data.sum(&:length)
  end

  def pad(string, width)
    string.rjust(width, '0')
  end

  def generate_key
    pad(rand(100_000).to_s, 5)
  end

  def generate_date
    Date.today.strftime('%d%m%y')
  end

  def quality_check1(key_date_data)
    return quality_check2(key_date_data) if combi_length(key_date_data) != 11
    key_date_data
  end

  def quality_check2(key_date_data)
    return quality_check3(key_date_data) if combi_length(key_date_data) != 6
    key_date_data.unshift(generate_key)
  end

  def quality_check3(key_date_data)
    return [generate_key, generate_date] if combi_length(key_date_data) != 5
    key_date_data.push(generate_date)
  end

  def key_date(key_date_data)
    quality_check1(key_date_data)
  end

  def frameshift(key) # Refactor with each_with_index.map
    shifts = []
    4.times do |index|
      shifts << key[index, 2]
    end

    shifts
  end

  def key_to_shifts(key)
    {
      A: frameshift(key)[0].to_i,
      B: frameshift(key)[1].to_i,
      C: frameshift(key)[2].to_i,
      D: frameshift(key)[3].to_i
    }
  end

  def process(date)
    (date.to_i ** 2).to_s[-4, 4]
  end

  def offsets(date)
    {
      A: process(date)[0].to_i,
      B: process(date)[1].to_i,
      C: process(date)[2].to_i,
      D: process(date)[3].to_i
    }
  end

  def total_shifts(key, date)
    offsets(date).reduce(key_to_shifts(key)) do |shifts, (letter, offset)|
      shifts[letter] += offset
      shifts
    end
  end

  def convert_to_shifts(key_date_data)
    total_shifts(key_date_data.first, key_date_data.last)
  end
end
