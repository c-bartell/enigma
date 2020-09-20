class Cipher
  attr_reader :shift

  def initialize(shift)
    @shift = shift
  end

  def set_shift(value)
    @shift = value
  end

  def characters
    ('a'..'z').to_a << ' '
  end

  def shifted_characters
    characters.rotate(shift)
  end

  def encrypt(letter)
    shifted_characters[characters.index(letter)]
  end
end
