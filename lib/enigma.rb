require './lib/crypt_manager'
require './lib/shift_generator'
require './lib/io_manager'

class Enigma
  attr_reader :crypt_manager, :shift_generator, :io_manager

  def initialize
    @crypt_manager = CryptManager.new(self)
    @shift_generator = ShiftGenerator.new(self)
    @io_manager = IOManager.new(self)
  end

  def key_date(key_date_data = [])
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

  def input_text
    io_manager.input_text
  end

  def key_input
    io_manager.key_input
  end

  def date_input
    io_manager.date_input
  end

  def finish(results, symbol)
    io_manager.finish(results, symbol)
  end

  def encrypt_file
    io_manager.get_text
    finish(encrypt(input_text, key_date), :encryption)
  end

  def decrypt_file
    io_manager.get_text
    finish(decrypt(input_text, key_input, date_input), :decryption)
  end
end
