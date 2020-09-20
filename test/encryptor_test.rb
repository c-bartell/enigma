require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def test_it_has_attributes
    enigma = mock('Enigma object')
    shift_generator = mock('ShiftGenerator object')
    cipher = mock('Cipher object')
    encryptor = Encryptor.new(enigma, shift_generator)


    assert_equal
  end
end
