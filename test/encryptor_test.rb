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

  def test_it_can_generate_a_shift_generator
    skip
    enigma = mock('Enigma object')
    cipher = mock('Cipher object')
    Cipher.stubs(:new).returns(cipher)
    encryptor = Encryptor.new(enigma)

    assert_instance_of ShiftGenerator, encryptor.shift_generator
  end

  def test_it_can_generate_a_cipher
    enigma = mock('Enigma object')
    shift_generator = mock('ShiftGenerator object')
    ShiftGenerator.stubs(:new).returns(shift_generator)
    encryptor = Encryptor.new(enigma)

    assert_instance_of Cipher, encryptor.cipher
  end
end
