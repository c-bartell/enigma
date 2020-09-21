require './lib/encryptor'
require './lib/shift_generator'

class Enigma
  attr_reader :encryptor, :shift_generator

  def initialize
    @encryptor = Encryptor.new(self)
    @shift_generator = ShiftGenerator.new(self)
  end

  def key_date(key_date_data)
    shift_generator.key_date(key_date_data)
  end

  def request_shifts(key_date_data)
    shift_generator.convert_to_shifts(key_date_data)
  end

  def encrypt(message, *key_date_data)
    encryptor.encrypt(message, key_date(key_date_data))
  end
end
