class Cipher
  attr_reader :a_shift, :b_shift, :c_shift, :d_shift

  def initialize
    @a_shift = nil
    @b_shift = nil
    @c_shift = nil
    @d_shift = nil
  end
  #
  # def set_shift(value)
  #   @shift = value
  # end
  #
  # def characters
  #   ('a'..'z').to_a << ' '
  # end
  #
  # def shifted_characters
  #   characters.rotate(shift)
  # end
  #
  # def encrypt(letter)
  #   shifted_characters[characters.index(letter)]
  # end
end
