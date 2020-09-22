require './lib/crypt_manager'
require './lib/shift_generator'
require './lib/io_manager'

class Enigma
  attr_reader :crypt_manager, :shift_generator

  def initialize
    @crypt_manager = CryptManager.new(self)
    @shift_generator = ShiftGenerator.new(self)
  end

  def key_date(key_date_data)
    shift_generator.key_date(key_date_data)
  end

  def request_shifts(key_date_data)
    shift_generator.convert_to_shifts(key_date_data)
  end

  def encrypt(message, *key_date_data)
    crypt_manager.encrypt(message, key_date(key_date_data))
  end

  def decrypt(ciphertext, key, date)
    crypt_manager.decrypt(ciphertext, [key, date])
  end
end
