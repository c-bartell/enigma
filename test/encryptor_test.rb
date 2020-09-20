require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def test_it_has_attributes
    enigma = mock('Enigma object')
    shift_generator = mock('ShiftGenerator object')
    cipher = mock('Cipher object')
    Encryptor.stubs(:generate_cipher).returns(cipher)
    Encryptor.stubs(:generate_shift_generator)
    encryptor = Encryptor.new(enigma)

    assert_equal enigma, encryptor.enigma
    assert_equal shift_generator, encryptor.shift_generator
    assert_equal cipher, encryptor.cipher    
  end
end
