class Cipher
  attr_reader :shift

  def initialize(shift)
    @shift = shift
  end

  def characters
    ('a'..'z').to_a << ' '
  end
end
