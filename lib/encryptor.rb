require './lib/cipher'
require './lib/shift_generator'

class Encryptor
  attr_reader :enigma, :shift_generator, :cipher

  def initialize(enigma)
    @enigma = enigma
    @shift_generator = generate_shift_generator
    @cipher = generate_cipher
  end

  def generate_shift_generator
    ShiftGenerator.new(self)
  end

  def generate_cipher
    Cipher.new(self)
  end

  def format(message)
    message.downcase.chomp.split('')
  end

  def request_shifts(key_date_data)
    shift_generator.generate_shifts(key_date_data)
  end
end
