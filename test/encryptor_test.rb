require './test/test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test  
  def test_it_has_attributes
    enigma = mock('Enigma object')
    shift_generator = mock('ShiftGenerator object')
    cipher = mock('Cipher object')
    ShiftGenerator.stubs(:new).returns(shift_generator)
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)

    assert_equal enigma, encryptor.enigma
    assert_equal shift_generator, encryptor.shift_generator
    assert_equal cipher, encryptor.cipher
  end


end
