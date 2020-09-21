require './test/test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_has_attributes
    encryptor = mock('Encryptor object')
    Encryptor.stubs(:new).returns(encryptor)
    shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(shift_generator)
    enigma = Enigma.new

    assert_equal encryptor, enigma.encryptor
    assert_equal shift_generator, enigma.shift_generator
  end
end
