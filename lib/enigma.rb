require './lib/encryptor'
require './lib/shift_generator'

class Enigma
  attr_reader :encryptor, :shift_generator

  def initialize
    @encryptor = Encryptor.new(self)
    @shift_generator = ShiftGenerator.new(self)
  end
end
