require './lib/cipher'
require './lib/shift_generator'

class Encryptor
  attr_reader :enigma, :cipher

  def initialize(enigma)
    @enigma = enigma
    @cipher = generate_cipher
  end

  def generate_cipher
    Cipher.new(self)
  end

  def format(message)
    message.downcase.chomp.split('')
  end

  def request_shifts(key_date_data)
    enigma.request_shifts(key_date_data)
  end
end
